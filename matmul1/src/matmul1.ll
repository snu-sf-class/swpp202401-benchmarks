; ModuleID = '.tmp/a.ll'
source_filename = "matmul1/src/matmul1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @matmul(i32 noundef %dim, ptr noundef %c, ptr noundef %a, ptr noundef %b) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc20, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc21, %for.inc20 ]
  %cmp = icmp ult i32 %i.0, %dim
  br i1 %cmp, label %for.body, label %for.end22

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc17, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc18, %for.inc17 ]
  %cmp2 = icmp ult i32 %j.0, %dim
  br i1 %cmp2, label %for.body3, label %for.end19

for.body3:                                        ; preds = %for.cond1
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %k.0 = phi i32 [ 0, %for.body3 ], [ %inc, %for.inc ]
  %sum.0 = phi i64 [ 0, %for.body3 ], [ %add12, %for.inc ]
  %cmp5 = icmp ult i32 %k.0, %dim
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %mul = mul i32 %i.0, %dim
  %add = add i32 %mul, %k.0
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr %a, i64 %idxprom
  %0 = load i64, ptr %arrayidx, align 8
  %mul7 = mul i32 %k.0, %dim
  %add8 = add i32 %mul7, %j.0
  %idxprom9 = zext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds i64, ptr %b, i64 %idxprom9
  %1 = load i64, ptr %arrayidx10, align 8
  %mul11 = mul i64 %0, %1
  %add12 = add i64 %sum.0, %mul11
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %inc = add i32 %k.0, 1
  br label %for.cond4, !llvm.loop !5

for.end:                                          ; preds = %for.cond4
  %mul13 = mul i32 %i.0, %dim
  %add14 = add i32 %mul13, %j.0
  %idxprom15 = zext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds i64, ptr %c, i64 %idxprom15
  store i64 %sum.0, ptr %arrayidx16, align 8
  br label %for.inc17

for.inc17:                                        ; preds = %for.end
  %inc18 = add i32 %j.0, 1
  br label %for.cond1, !llvm.loop !8

for.end19:                                        ; preds = %for.cond1
  br label %for.inc20

for.inc20:                                        ; preds = %for.end19
  %inc21 = add i32 %i.0, 1
  br label %for.cond, !llvm.loop !9

for.end22:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @read_mat(i32 noundef %dim, ptr noundef %mat) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc5, %for.inc4 ]
  %cmp = icmp ult i32 %i.0, %dim
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp ult i32 %j.0, %dim
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %call = call i64 (...) @read()
  %mul = mul i32 %i.0, %dim
  %add = add i32 %mul, %j.0
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr %mat, i64 %idxprom
  store i64 %call, ptr %arrayidx, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %inc = add i32 %j.0, 1
  br label %for.cond1, !llvm.loop !10

for.end:                                          ; preds = %for.cond1
  br label %for.inc4

for.inc4:                                         ; preds = %for.end
  %inc5 = add i32 %i.0, 1
  br label %for.cond, !llvm.loop !11

for.end6:                                         ; preds = %for.cond
  ret void
}

declare i64 @read(...) #2

; Function Attrs: nounwind uwtable
define dso_local void @print_mat(i32 noundef %dim, ptr noundef %mat) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc4, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc5, %for.inc4 ]
  %cmp = icmp ult i32 %i.0, %dim
  br i1 %cmp, label %for.body, label %for.end6

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp ult i32 %j.0, %dim
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %mul = mul i32 %i.0, %dim
  %add = add i32 %mul, %j.0
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr %mat, i64 %idxprom
  %0 = load i64, ptr %arrayidx, align 8
  call void @write(i64 noundef %0)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %inc = add i32 %j.0, 1
  br label %for.cond1, !llvm.loop !12

for.end:                                          ; preds = %for.cond1
  br label %for.inc4

for.inc4:                                         ; preds = %for.end
  %inc5 = add i32 %i.0, 1
  br label %for.cond, !llvm.loop !13

for.end6:                                         ; preds = %for.cond
  ret void
}

declare void @write(i64 noundef) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %mul = mul i32 %conv, %conv
  %conv1 = zext i32 %mul to i64
  %mul2 = mul i64 %conv1, 8
  %call3 = call noalias ptr @malloc(i64 noundef %mul2) #4
  %mul4 = mul i32 %conv, %conv
  %conv5 = zext i32 %mul4 to i64
  %mul6 = mul i64 %conv5, 8
  %call7 = call noalias ptr @malloc(i64 noundef %mul6) #4
  %mul8 = mul i32 %conv, %conv
  %conv9 = zext i32 %mul8 to i64
  %mul10 = mul i64 %conv9, 8
  %call11 = call noalias ptr @malloc(i64 noundef %mul10) #4
  call void @read_mat(i32 noundef %conv, ptr noundef %call3)
  call void @read_mat(i32 noundef %conv, ptr noundef %call7)
  call void @matmul(i32 noundef %conv, ptr noundef %call11, ptr noundef %call3, ptr noundef %call7)
  call void @print_mat(i32 noundef %conv, ptr noundef %call11)
  ret i32 0
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.0rc (https://github.com/llvm/llvm-project.git 461274b81d8641eab64d494accddc81d7db8a09e)"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.unroll.disable"}
!8 = distinct !{!8, !6, !7}
!9 = distinct !{!9, !6, !7}
!10 = distinct !{!10, !6, !7}
!11 = distinct !{!11, !6, !7}
!12 = distinct !{!12, !6, !7}
!13 = distinct !{!13, !6, !7}
