import { DashboardLayout } from '@/components/shared/DashboardLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/contexts/AuthContext';
import { ClipboardCheck, Users, FileText, TrendingUp } from 'lucide-react';

export default function TeacherDashboard() {
  const { user } = useAuth();

  const stats = [
    { icon: ClipboardCheck, label: 'Tests Created', value: '12', color: 'text-primary' },
    { icon: Users, label: 'Active Students', value: '45', color: 'text-success' },
    { icon: FileText, label: 'Content Uploaded', value: '8', color: 'text-accent' },
    { icon: TrendingUp, label: 'Avg Performance', value: '78%', color: 'text-chart-4' },
  ];

  return (
    <DashboardLayout>
      <div className="p-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">Welcome, {user?.name}!</h1>
          <p className="text-muted-foreground">Manage your classes and track student performance</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.label} className="shadow-card hover:shadow-card-hover transition-shadow">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {stat.label}
                </CardTitle>
                <stat.icon className={`w-5 h-5 ${stat.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold">{stat.value}</div>
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card className="shadow-card">
            <CardHeader>
              <CardTitle>Recent Student Submissions</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
                  <div>
                    <p className="font-medium">Rahul Kumar - Chapter 5 Summary</p>
                    <p className="text-sm text-muted-foreground">Uploaded 2 hours ago</p>
                  </div>
                  <span className="text-sm px-3 py-1 bg-accent/20 text-accent-foreground rounded-full">
                    Review
                  </span>
                </div>
                <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
                  <div>
                    <p className="font-medium">Priya Sharma - Maths Test</p>
                    <p className="text-sm text-muted-foreground">Completed today</p>
                  </div>
                  <span className="text-sm px-3 py-1 bg-success/20 text-success-foreground rounded-full">
                    Graded
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="shadow-card">
            <CardHeader>
              <CardTitle>Quick Actions</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <button className="w-full p-4 text-left bg-primary text-primary-foreground rounded-lg hover:opacity-90 transition-opacity">
                  <p className="font-medium">Create New Test</p>
                  <p className="text-sm opacity-90">Build from content library</p>
                </button>
                <button className="w-full p-4 text-left bg-success text-success-foreground rounded-lg hover:opacity-90 transition-opacity">
                  <p className="font-medium">Upload Teaching Material</p>
                  <p className="text-sm opacity-90">Generate study resources</p>
                </button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}
