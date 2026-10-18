package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class SecretwarFightItem extends Sprite
   {
      
      private var _mc:MovieClip;
      
      private var _owerKey:String = null;
      
      private var _emeryKey:String = null;
      
      public function SecretwarFightItem()
      {
         super();
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get owerKey() : String
      {
         return _owerKey;
      }
      
      public function get emeryKey() : String
      {
         return _emeryKey;
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("asset.secretwar.fightMc");
         addChild(_mc);
         _mc.mouseChildren = _mc.mouseEnabled = false;
      }
      
      public function updateKey(param1:String, param2:String, param3:Number, param4:Number) : void
      {
         _owerKey = param1;
         _emeryKey = param2;
         this.x = param3;
         this.y = param4;
      }
      
      public function play() : void
      {
         _mc.play();
      }
      
      public function hideFight() : void
      {
         _owerKey = null;
         _emeryKey = null;
         _mc.stop();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

