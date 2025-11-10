import { NavLink } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge'; // <-- NEW: Import Badge component
import { 
  GraduationCap, 
  LayoutDashboard, 
  BookOpen, 
  FileText, 
  ClipboardCheck, 
  BarChart3, 
  MessageSquare,
  Users,
  LogOut,
  PenTool,
  FolderOpen
} from 'lucide-react';
import { cn } from '@/lib/utils';

// --- NEW NavItem Interface ---
interface NavItem {
  to: string;
  icon: React.ElementType;
  label: string;
  status?: 'coming-soon'; // <-- NEW: Status property
}
// -----------------------------

export function Sidebar() {
  const { user, logout } = useAuth();

  const getNavItems = (): NavItem[] => {
    if (!user) return [];

    switch (user.role) {
      case 'student':
        return [
          { to: '/student/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
          { to: '/student/books', icon: BookOpen, label: 'My Books' },
          { to: '/student/my-content', icon: FileText, label: 'My Content' },
          { to: '/student/tests', icon: ClipboardCheck, label: 'Tests' },
          { to: '/student/performance', icon: BarChart3, label: 'Performance' },
          // --- CHAT: MARKED AS COMING SOON ---
          { to: '/student/chat', icon: MessageSquare, label: 'Chat', status: 'coming-soon' }, 
        ];
      case 'teacher':
        return [
          { to: '/teacher/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
          { to: '/teacher/books', icon: BookOpen, label: 'Books' },
          { to: '/teacher/my-content', icon: FileText, label: 'My Content' },
          { to: '/teacher/student-content', icon: FolderOpen, label: 'Student Content' },
          { to: '/teacher/create-test', icon: PenTool, label: 'Create Test' },
          { to: '/teacher/analytics', icon: BarChart3, label: 'Analytics' },
          // --- CHAT: MARKED AS COMING SOON ---
          { to: '/teacher/chat', icon: MessageSquare, label: 'Chat', status: 'coming-soon' },
        ];
      case 'principal':
        return [
          { to: '/principal/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
          { to: '/principal/users', icon: Users, label: 'User Management' },
          { to: '/principal/analytics', icon: BarChart3, label: 'Analytics' },
          { to: '/principal/content', icon: FolderOpen, label: 'Books & Content' },
          // --- CHAT: MARKED AS COMING SOON (Optional for Principal) ---
          { to: '/principal/chat', icon: MessageSquare, label: 'Chat', status: 'coming-soon' },
        ];
      default:
        return [];
    }
  };

  const navItems = getNavItems();

  return (
    <aside className="w-64 bg-sidebar border-r border-sidebar-border flex flex-col">
      <div className="p-6 border-b border-sidebar-border">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-sidebar-primary rounded-xl flex items-center justify-center">
            <GraduationCap className="w-6 h-6 text-sidebar-primary-foreground" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-sidebar-foreground">Studious</h1>
            <p className="text-xs text-sidebar-foreground/70 capitalize">{user?.role}</p>
          </div>
        </div>
      </div>

      <nav className="flex-1 p-4 space-y-1">
        {navItems.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            // Disable link functionality and change styling if status is 'coming-soon'
            onClick={(e) => item.status === 'coming-soon' && e.preventDefault()}
            className={({ isActive }) =>
              cn(
                'flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200',
                'text-sidebar-foreground',
                isActive && 'bg-sidebar-accent font-medium',
                item.status === 'coming-soon' ? 'text-sidebar-foreground/50 cursor-not-allowed hover:bg-transparent' : 'hover:bg-sidebar-accent',
                isActive && item.status !== 'coming-soon' && 'bg-sidebar-accent font-medium'
              )
            }
          >
            <item.icon className="w-5 h-5" />
            <span>{item.label}</span>
            {/* --- NEW: Render Badge if Coming Soon --- */}
            {item.status === 'coming-soon' && (
                <Badge 
                    variant="default" 
                    className="ml-auto text-xs bg-yellow-400/20 text-yellow-500 font-semibold h-5 hover:bg-yellow-400/20"
                >
                    Soon
                </Badge>
            )}
          </NavLink>
        ))}
      </nav>

      <div className="p-4 border-t border-sidebar-border">
        <div className="mb-4 p-3 bg-sidebar-accent rounded-lg">
          <p className="text-sm font-medium text-sidebar-foreground">{user?.name}</p>
          <p className="text-xs text-sidebar-foreground/70">{user?.email}</p>
        </div>
        <Button
          onClick={logout}
          variant="outline"
          className="w-full justify-start gap-3"
        >
          <LogOut className="w-5 h-5" />
          Sign Out
        </Button>
      </div>
    </aside>
  );
}