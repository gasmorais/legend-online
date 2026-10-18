package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNsLifeWheelExpItem extends Component
   {
      
      private var addImage:Bitmap;
      
      private var expContiner:Component;
      
      private var numBitmap:BitmapData;
      
      private var tipArea:Component;
      
      private var _isLock:Boolean;
      
      private var index:int;
      
      private var expArr:Array;
      
      private var lockMaxCount:int;
      
      public function ChildNsLifeWheelExpItem(param1:int)
      {
         super();
         index = param1;
         expArr = ConfigInfoManager.instance.getChildNsLifeWheelExp();
         lockMaxCount = ConfigInfoManager.instance.getChildNsExpLockMaxCount();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         addImage = ComponentFactory.Instance.creatBitmap("asset.ChildNsLifeWheelExpItem.addImage");
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.ChildNsLifeWheelExpItem.numBitmap");
         expContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNsLifeWheelExpItem.expContiner");
         tipArea = ComponentFactory.Instance.creatComponentByStylename("ChildNsLifeWheelExpItem.tipArea");
         tipArea.graphics.clear();
         tipArea.graphics.beginFill(0,0);
         tipArea.graphics.drawCircle(15,10,16);
         addChild(addImage);
         addChild(expContiner);
         addChild(tipArea);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__onCloseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onCloseClickHandler);
      }
      
      private function __onCloseClickHandler(param1:MouseEvent) : void
      {
         if(nsModel.isKeySelected)
         {
            return;
         }
         if(!isLock && nsModel.expLockCount >= lockMaxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNsLifeWheelExpItem.lock.overAlert"));
            return;
         }
         isLock = !isLock;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         expContiner.visible = addImage.visible = !isLock;
         updateTips();
         MsgMan.notifyObserver("ChildEvent.CHILD_NS_LIFEWHEEL_LOCK");
      }
      
      public function refreshView() : void
      {
         updateTips();
         NumberViewUtils.refreshValue(expArr[index],expContiner,numBitmap,14,15,8,14,"0123456789");
      }
      
      private function updateTips() : void
      {
         var _loc4_:String = null;
         var _loc2_:String = LanguageMgr.GetTranslation("ChildNsLifeWheelExpItem.tipdata.titleText");
         var _loc1_:String = LanguageMgr.GetTranslation("ChildNsLifeWheelExpItem.tipdata.expText",expArr[index]);
         var _loc5_:String = LanguageMgr.GetTranslation("ChildNsLifeWheelExpItem.tipData.notOpenText");
         var _loc3_:String = LanguageMgr.GetTranslation("ChildNsLifeWheelExpItem.tipData.canCloseText");
         _loc4_ = "<font color=\'#5ccae9\'>" + _loc2_ + "\n" + "</font>" + "<font color=\'#ffe400\'>" + _loc1_ + "\n" + "</font>";
         if(isLock)
         {
            _loc4_ += "<font color=\'#ff4504\'>" + _loc5_ + "</font>";
         }
         else
         {
            _loc4_ += "<font color=\'#ff4504\'>" + _loc3_ + "</font>";
         }
         tipArea.tipData = _loc4_;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(addImage);
         addImage = null;
         ObjectUtils.disposeObject(expContiner);
         expContiner = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         ObjectUtils.disposeObject(tipArea);
         tipArea = null;
         super.dispose();
      }
   }
}

