package map.campaign.view.ui.bloody
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.mediator.bloody.BloodyManager;
   import yishi.GlobalConfig;
   import yishi.view.tips.MessageTipManager;
   
   public class EggItemView extends Component
   {
      
      private var _index:int;
      
      private var _staticEgg:DisplayObject;
      
      private var _egg:MovieClip;
      
      private var _isOpen:Boolean = false;
      
      public function EggItemView(param1:int)
      {
         _index = param1;
         super();
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",_clickHandler);
      }
      
      private function initView() : void
      {
         _staticEgg = ComponentFactory.Instance.creat("asset.bloody.staticEgg");
         addChild(_staticEgg);
         this.buttonMode = true;
      }
      
      public function get indexBox() : int
      {
         return _index;
      }
      
      public function playEggByType(param1:int) : void
      {
         var type:int = param1;
         if(type < 1 || type > 4)
         {
            return;
         }
         if(_isOpen)
         {
            return;
         }
         _isOpen = true;
         _staticEgg && _staticEgg.parent && _staticEgg.parent.removeChild(_staticEgg);
         _egg = ComponentFactory.Instance.creat("asset.bloody.egg" + type);
         addChild(_egg);
         _egg.addFrameScript(_egg.totalFrames - 1,function():void
         {
            _egg.stop();
         });
         _egg.gotoAndPlay(1);
      }
      
      protected function _clickHandler(param1:MouseEvent) : void
      {
         if(GlobalConfig.isGet)
         {
            if(BloodyManager.instance.myClickEggIndex == -1)
            {
               BloodyManager.instance.myClickEggIndex = _index;
               BloodySocketOut.poundEgg();
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.ui.molong.isNotGetTip"));
         }
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("click",_clickHandler);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

