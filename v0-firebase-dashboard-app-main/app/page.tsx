"use client"

import { useAuth } from "@/contexts/auth-context"
import { AuthForm } from "@/components/auth-form"
import { Dashboard } from "@/components/dashboard"
import { Loader2 } from "lucide-react"

export default function Home() {
  const { user, loading } = useAuth()

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-muted/30">
        <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
      </div>
    )
  }

  return user ? <Dashboard /> : <AuthForm />
}
