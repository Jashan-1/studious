import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/auth/ProtectedRoute";
import Login from "./pages/Login";
import StudentDashboard from "./pages/student/Dashboard";
import StudentBooks from "./pages/student/Books";
import StudentMyContent from "./pages/student/MyContent";
import TeacherDashboard from "./pages/teacher/Dashboard";
import TeacherBooks from "./pages/teacher/Books";
import TeacherMyContent from "./pages/teacher/MyContent";
import PrincipalDashboard from "./pages/principal/Dashboard";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <AuthProvider>
          <Routes>
            <Route path="/" element={<Navigate to="/login" replace />} />
            <Route path="/login" element={<Login />} />
            
            {/* Student Routes */}
            <Route
              path="/student/dashboard"
              element={
                <ProtectedRoute allowedRoles={['student']}>
                  <StudentDashboard />
                </ProtectedRoute>
              }
            />
            <Route
              path="/student/books"
              element={
                <ProtectedRoute allowedRoles={['student']}>
                  <StudentBooks />
                </ProtectedRoute>
              }
            />
            <Route
              path="/student/my-content"
              element={
                <ProtectedRoute allowedRoles={['student']}>
                  <StudentMyContent />
                </ProtectedRoute>
              }
            />
            
            {/* Teacher Routes */}
            <Route
              path="/teacher/dashboard"
              element={
                <ProtectedRoute allowedRoles={['teacher']}>
                  <TeacherDashboard />
                </ProtectedRoute>
              }
            />
            <Route
              path="/teacher/books"
              element={
                <ProtectedRoute allowedRoles={['teacher']}>
                  <TeacherBooks />
                </ProtectedRoute>
              }
            />
            <Route
              path="/teacher/my-content"
              element={
                <ProtectedRoute allowedRoles={['teacher']}>
                  <TeacherMyContent />
                </ProtectedRoute>
              }
            />
            
            {/* Principal Routes */}
            <Route
              path="/principal/dashboard"
              element={
                <ProtectedRoute allowedRoles={['principal']}>
                  <PrincipalDashboard />
                </ProtectedRoute>
              }
            />
            
            <Route path="*" element={<NotFound />} />
          </Routes>
        </AuthProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
