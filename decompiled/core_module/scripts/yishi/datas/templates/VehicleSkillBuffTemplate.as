package yishi.datas.templates
{
   import flash.utils.Timer;
   
   public class VehicleSkillBuffTemplate
   {
      
      public var TemplateId:int;
      
      public var Name:String;
      
      public var Icon:String;
      
      public var EffectType:int;
      
      public var EffectValue:int;
      
      public var EffectPercent:int;
      
      public var TogglePercent:int;
      
      public var Duration:int;
      
      public var Description:String;
      
      public var PrepareTime:int;
      
      public var Interval:int;
      
      public var LastEffect:String;
      
      private var _timer:Timer;
      
      public function VehicleSkillBuffTemplate()
      {
         super();
      }
      
      public function setTimer() : void
      {
         if(_timer == null)
         {
            _timer = new Timer(1000);
         }
         _timer.reset();
         _timer.start();
      }
      
      public function get leftTime() : int
      {
         var _loc1_:int = 0;
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.reset();
            _timer.start();
         }
         if(!_timer.running)
         {
            return 0;
         }
         _loc1_ = int(Duration / 1000) - _timer.currentCount;
         if(_loc1_ <= 0)
         {
            _timer.stop();
            _loc1_ = 0;
         }
         return _loc1_;
      }
   }
}

