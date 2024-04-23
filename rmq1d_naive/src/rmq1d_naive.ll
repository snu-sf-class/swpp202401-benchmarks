; ModuleID = '.tmp/a.ll'
source_filename = "rmq1d_naive/src/rmq1d_naive.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local ptr @malloc_upto_8(i64 noundef %x) #0 {
entry:
  %add = add i64 %x, 7
  %div = udiv i64 %add, 8
  %mul = mul i64 %div, 8
  %call = call noalias ptr @malloc(i64 noundef %mul) #4
  ret ptr %call
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @min_element(ptr noundef %p, ptr noundef %q) #0 {
entry:
  %0 = load i32, ptr %p, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %p.addr.0 = phi ptr [ %p, %entry ], [ %incdec.ptr, %if.end ]
  %e.0 = phi i32 [ %0, %entry ], [ %e.1, %if.end ]
  %cmp = icmp ne ptr %p.addr.0, %q
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32, ptr %p.addr.0, align 4
  %cmp1 = icmp slt i32 %1, %e.0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %2 = load i32, ptr %p.addr.0, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %e.1 = phi i32 [ %2, %if.then ], [ %e.0, %while.body ]
  %incdec.ptr = getelementptr inbounds i32, ptr %p.addr.0, i64 1
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %while.cond
  ret i32 %e.0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %conv1 = sext i32 %conv to i64
  %mul = mul i64 4, %conv1
  %call2 = call ptr @malloc_upto_8(i64 noundef %mul)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %conv
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %call4 = call i64 (...) @read()
  %conv5 = trunc i64 %call4 to i32
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %call2, i64 %idxprom
  store i32 %conv5, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond.cleanup
  %call6 = call i64 (...) @read()
  %conv7 = trunc i64 %call6 to i32
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.end
  %Q.0 = phi i32 [ %conv7, %for.end ], [ %dec, %while.body ]
  %dec = add nsw i32 %Q.0, -1
  %tobool = icmp ne i32 %Q.0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call8 = call i64 (...) @read()
  %conv9 = trunc i64 %call8 to i32
  %call10 = call i64 (...) @read()
  %conv11 = trunc i64 %call10 to i32
  %idx.ext = sext i32 %conv9 to i64
  %add.ptr = getelementptr inbounds i32, ptr %call2, i64 %idx.ext
  %idx.ext12 = sext i32 %conv11 to i64
  %add.ptr13 = getelementptr inbounds i32, ptr %call2, i64 %idx.ext12
  %add.ptr14 = getelementptr inbounds i32, ptr %add.ptr13, i64 1
  %call15 = call i32 @min_element(ptr noundef %add.ptr, ptr noundef %add.ptr14)
  %conv16 = sext i32 %call15 to i64
  call void @write(i64 noundef %conv16)
  br label %while.cond, !llvm.loop !9

while.end:                                        ; preds = %while.cond
  ret i32 0
}

declare i64 @read(...) #3

declare void @write(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
