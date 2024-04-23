; ModuleID = '.tmp/a.ll'
source_filename = "bitcount4/src/bitcount4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@BitsSetTable256 = external global [256 x i32], align 16

; Function Attrs: nounwind uwtable
define dso_local i32 @countSetBits(i32 noundef %n) #0 {
entry:
  %and = and i32 %n, 255
  %idxprom = sext i32 %and to i64
  %arrayidx = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %shr = ashr i32 %n, 8
  %and1 = and i32 %shr, 255
  %idxprom2 = sext i32 %and1 to i64
  %arrayidx3 = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom2
  %1 = load i32, ptr %arrayidx3, align 4
  %add = add nsw i32 %0, %1
  %shr4 = ashr i32 %n, 16
  %and5 = and i32 %shr4, 255
  %idxprom6 = sext i32 %and5 to i64
  %arrayidx7 = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom6
  %2 = load i32, ptr %arrayidx7, align 4
  %add8 = add nsw i32 %add, %2
  %shr9 = ashr i32 %n, 24
  %idxprom10 = sext i32 %shr9 to i64
  %arrayidx11 = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom10
  %3 = load i32, ptr %arrayidx11, align 4
  %add12 = add nsw i32 %add8, %3
  ret i32 %add12
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  store i32 0, ptr @BitsSetTable256, align 16
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 256
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %and = and i32 %i.0, 1
  %div = sdiv i32 %i.0, 2
  %idxprom = sext i32 %div to i64
  %arrayidx = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %add = add nsw i32 %and, %0
  %idxprom1 = sext i32 %i.0 to i64
  %arrayidx2 = getelementptr inbounds [256 x i32], ptr @BitsSetTable256, i64 0, i64 %idxprom1
  store i32 %add, ptr %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond.cleanup
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %call3 = call i32 @countSetBits(i32 noundef %conv)
  %conv4 = sext i32 %call3 to i64
  call void @write(i64 noundef %conv4)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @write(i64 noundef) #2

declare i64 @read(...) #2

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
