import { DashboardLayout } from '@/components/shared/DashboardLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/contexts/AuthContext';
import { Users, GraduationCap, ClipboardCheck, Activity } from 'lucide-react';

export default function PrincipalDashboard() {
  const { user } = useAuth();

  const stats = [
    { icon: Users, label: 'Total Students', value: '450', color: 'text-primary' },
    { icon: GraduationCap, label: 'Total Teachers', value: '28', color: 'text-success' },
    { icon: ClipboardCheck, label: 'Tests Completed', value: '1,234', color: 'text-accent' },
    { icon: Activity, label: 'Active Users', value: '312', color: 'text-chart-4' },
  ];

  return (
    <DashboardLayout>
      <div className="p-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">Welcome, {user?.name}!</h1>
          <p className="text-muted-foreground">Overview of your school's learning platform</p>
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
              <CardTitle>Token Usage Overview</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-muted-foreground">Total Tokens Used</span>
                  <span className="text-2xl font-bold">125,430</span>
                </div>
                <div className="w-full bg-muted rounded-full h-2">
                  <div className="bg-primary h-2 rounded-full" style={{ width: '65%' }}></div>
                </div>
                <div className="grid grid-cols-2 gap-4 pt-2">
                  <div>
                    <p className="text-xs text-muted-foreground">This Month</p>
                    <p className="text-lg font-semibold">45,230</p>
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground">Top User</p>
                    <p className="text-lg font-semibold">Teacher A</p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="shadow-card">
            <CardHeader>
              <CardTitle>Recent Activity</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-start gap-3 p-3 bg-muted rounded-lg">
                  <div className="w-2 h-2 mt-2 rounded-full bg-primary"></div>
                  <div>
                    <p className="text-sm font-medium">New student registered</p>
                    <p className="text-xs text-muted-foreground">Class 10 - 5 minutes ago</p>
                  </div>
                </div>
                <div className="flex items-start gap-3 p-3 bg-muted rounded-lg">
                  <div className="w-2 h-2 mt-2 rounded-full bg-success"></div>
                  <div>
                    <p className="text-sm font-medium">Test submitted by Teacher B</p>
                    <p className="text-xs text-muted-foreground">Science - 1 hour ago</p>
                  </div>
                </div>
                <div className="flex items-start gap-3 p-3 bg-muted rounded-lg">
                  <div className="w-2 h-2 mt-2 rounded-full bg-accent"></div>
                  <div>
                    <p className="text-sm font-medium">Content uploaded</p>
                    <p className="text-xs text-muted-foreground">Mathematics - 3 hours ago</p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}
