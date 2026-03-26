"use client"

import { useState, useEffect } from "react"
import { useAuth } from "@/contexts/auth-context"
import { addTask, deleteTask, subscribeTasks, type Task } from "@/lib/tasks"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { LogOut, Plus, Trash2, ListTodo, Loader2 } from "lucide-react"

export function Dashboard() {
  const { user, logout } = useAuth()
  const [tasks, setTasks] = useState<Task[]>([])
  const [loading, setLoading] = useState(true)
  const [title, setTitle] = useState("")
  const [description, setDescription] = useState("")
  const [adding, setAdding] = useState(false)
  const [deletingId, setDeletingId] = useState<string | null>(null)

  useEffect(() => {
    if (!user) return

    const unsubscribe = subscribeTasks(user.uid, (tasks) => {
      setTasks(tasks)
      setLoading(false)
    })

    return () => unsubscribe()
  }, [user])

  const handleAddTask = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!user || !title.trim()) return

    setAdding(true)
    try {
      await addTask(user.uid, {
        title: title.trim(),
        description: description.trim() || undefined,
      })
      setTitle("")
      setDescription("")
    } catch (error) {
      console.error("Error adding task:", error)
    } finally {
      setAdding(false)
    }
  }

  const handleDeleteTask = async (taskId: string) => {
    setDeletingId(taskId)
    try {
      await deleteTask(taskId)
    } catch (error) {
      console.error("Error deleting task:", error)
    } finally {
      setDeletingId(null)
    }
  }

  const handleLogout = async () => {
    try {
      await logout()
    } catch (error) {
      console.error("Error logging out:", error)
    }
  }

  return (
    <div className="min-h-screen bg-muted/30">
      {/* Header */}
      <header className="bg-background border-b sticky top-0 z-10">
        <div className="max-w-4xl mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <ListTodo className="h-6 w-6 text-primary" />
            <h1 className="text-xl font-semibold">My Tasks</h1>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-sm text-muted-foreground hidden sm:block">
              {user?.email}
            </span>
            <Button variant="outline" size="sm" onClick={handleLogout}>
              <LogOut className="h-4 w-4 mr-2" />
              Sign Out
            </Button>
          </div>
        </div>
      </header>

      <main className="max-w-4xl mx-auto px-4 py-8">
        {/* Add Task Form */}
        <Card className="mb-8">
          <CardHeader>
            <CardTitle>Add New Task</CardTitle>
            <CardDescription>Create a new task to add to your list</CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleAddTask} className="space-y-4">
              <div>
                <Input
                  placeholder="Task title"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  required
                  disabled={adding}
                />
              </div>
              <div>
                <Textarea
                  placeholder="Description (optional)"
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  rows={2}
                  disabled={adding}
                />
              </div>
              <Button type="submit" disabled={adding || !title.trim()}>
                {adding ? (
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                ) : (
                  <Plus className="h-4 w-4 mr-2" />
                )}
                Add Task
              </Button>
            </form>
          </CardContent>
        </Card>

        {/* Tasks List */}
        <Card>
          <CardHeader>
            <CardTitle>Your Tasks</CardTitle>
            <CardDescription>
              {loading
                ? "Loading tasks..."
                : `You have ${tasks.length} task${tasks.length !== 1 ? "s" : ""}`}
            </CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="flex items-center justify-center py-8">
                <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
              </div>
            ) : tasks.length === 0 ? (
              <div className="text-center py-8 text-muted-foreground">
                <ListTodo className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>No tasks yet. Add your first task above!</p>
              </div>
            ) : (
              <ul className="space-y-3">
                {tasks.map((task) => (
                  <li
                    key={task.id}
                    className="flex items-start justify-between p-4 bg-muted/50 rounded-lg border"
                  >
                    <div className="flex-1 min-w-0 pr-4">
                      <h3 className="font-medium text-foreground">{task.title}</h3>
                      {task.description && (
                        <p className="text-sm text-muted-foreground mt-1">
                          {task.description}
                        </p>
                      )}
                      <p className="text-xs text-muted-foreground mt-2">
                        {task.createdAt.toLocaleDateString("en-US", {
                          month: "short",
                          day: "numeric",
                          year: "numeric",
                          hour: "2-digit",
                          minute: "2-digit",
                        })}
                      </p>
                    </div>
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => handleDeleteTask(task.id)}
                      disabled={deletingId === task.id}
                      className="text-muted-foreground hover:text-destructive shrink-0"
                    >
                      {deletingId === task.id ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                      ) : (
                        <Trash2 className="h-4 w-4" />
                      )}
                      <span className="sr-only">Delete task</span>
                    </Button>
                  </li>
                ))}
              </ul>
            )}
          </CardContent>
        </Card>
      </main>
    </div>
  )
}
