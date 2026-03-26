import {
  collection,
  addDoc,
  deleteDoc,
  doc,
  query,
  where,
  orderBy,
  onSnapshot,
  serverTimestamp,
  type Unsubscribe,
} from "firebase/firestore"
import { db } from "./firebase"

export interface Task {
  id: string
  title: string
  description?: string
  completed: boolean
  createdAt: Date
  userId: string
}

export interface TaskInput {
  title: string
  description?: string
}

// Add a new task
export async function addTask(userId: string, task: TaskInput): Promise<string> {
  const docRef = await addDoc(collection(db, "tasks"), {
    ...task,
    completed: false,
    userId,
    createdAt: serverTimestamp(),
  })
  return docRef.id
}

// Delete a task
export async function deleteTask(taskId: string): Promise<void> {
  await deleteDoc(doc(db, "tasks", taskId))
}

// Subscribe to user's tasks (real-time updates)
export function subscribeTasks(
  userId: string,
  callback: (tasks: Task[]) => void
): Unsubscribe {
  const q = query(
    collection(db, "tasks"),
    where("userId", "==", userId),
    orderBy("createdAt", "desc")
  )

  return onSnapshot(q, (snapshot) => {
    const tasks: Task[] = snapshot.docs.map((doc) => ({
      id: doc.id,
      title: doc.data().title,
      description: doc.data().description,
      completed: doc.data().completed,
      createdAt: doc.data().createdAt?.toDate() || new Date(),
      userId: doc.data().userId,
    }))
    callback(tasks)
  })
}
