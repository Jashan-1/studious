import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useNavigate } from 'react-router-dom';

type UserRole = 'student' | 'teacher' | 'principal';

interface User {
  id: string;
  email: string;
  name: string;
  role: UserRole;
  class?: string;
}

interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    // Check for stored user session
    const storedUser = localStorage.getItem('studious_user');
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
    setIsLoading(false);
  }, []);

  const login = async (email: string, password: string) => {
    setIsLoading(true);
    try {
      // TODO: Replace with actual Firebase Auth API call
      // Simulating API call for now
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Mock user based on email pattern
      const mockUser: User = {
        id: '1',
        email,
        name: email.split('@')[0],
        role: email.includes('student') ? 'student' : 
              email.includes('teacher') ? 'teacher' : 'principal',
        class: email.includes('student') ? 'Class 10' : undefined
      };

      setUser(mockUser);
      localStorage.setItem('studious_user', JSON.stringify(mockUser));

      // Redirect based on role
      switch (mockUser.role) {
        case 'student':
          navigate('/student/dashboard');
          break;
        case 'teacher':
          navigate('/teacher/dashboard');
          break;
        case 'principal':
          navigate('/principal/dashboard');
          break;
      }
    } catch (error) {
      console.error('Login error:', error);
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('studious_user');
    navigate('/login');
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
