package battle.skillsys.skills
{
   import battle.data.BufferDamageData;
   
   public class EmptyActionSkill extends BaseSkill
   {
      
      public function EmptyActionSkill()
      {
         super();
      }
      
      override protected function startRun() : void
      {
         skillComplete();
         started = true;
      }
      
      override protected function bufferProcess(param1:Boolean = false) : void
      {
         var _loc3_:BufferDamageData = null;
         var _loc2_:int = 0;
         if(_skillData.buffers && _skillData.buffers.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _skillData.buffers.length)
            {
               _loc3_ = _skillData.buffers[_loc2_];
               executeBufferAffectives(_loc3_);
               _loc2_++;
            }
         }
      }
   }
}

