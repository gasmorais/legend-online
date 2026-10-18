package map.internals.view.hero
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import stage3drender.avatar.AvatarRender;
   
   public class BaseNameView extends Sprite
   {
      
      public var heroView:AvatarRender;
      
      protected var _isPlaying:Boolean = true;
      
      protected var _npcName:FilterFrameText;
      
      public var isDie:Boolean = false;
      
      public function BaseNameView()
      {
         this.mouseChildren = this.mouseEnabled = false;
         super();
      }
      
      public function execute() : void
      {
      }
      
      public function layout() : void
      {
      }
      
      protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         _npcName || (_npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText"));
         _npcName.cacheAsBitmap = true;
         if(param1 != "")
         {
            _npcName.text = param1;
         }
         if(param2 > 0)
         {
            _npcName.appendText(" " + LanguageMgr.GetTranslation("public.level2",param2));
         }
         _npcName.x = -_npcName.width / 2;
         _npcName.selectable = _npcName.mouseEnabled = _npcName.mouseWheelEnabled = false;
         if(_isPlaying)
         {
            addChild(_npcName);
         }
         param5 = int(param5 == 0 ? 1 : param5);
         _npcName.setFrame(param5);
         _npcName.y = -110;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         isDie = true;
         heroView = null;
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
      }
      
      public function get npcName() : FilterFrameText
      {
         return _npcName;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      protected function getPosYBySizeType(param1:int, param2:int = 0) : int
      {
         var _loc3_:int = -125;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = -125;
               break;
            case 1:
               _loc3_ = -150;
               break;
            case 2:
            case 9:
               _loc3_ = -165;
               break;
            case 6:
               _loc3_ = -80;
         }
         return _loc3_ + param2;
      }
   }
}

