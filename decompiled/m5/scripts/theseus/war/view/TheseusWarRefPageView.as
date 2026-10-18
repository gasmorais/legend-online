package theseus.war.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarRfineInfo;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusWarIntensifyCell;
   import theseus.war.item.TheseusWarMetrailCell;
   import theseus.war.item.TheseusWarRefineItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TextAddBitmap;
   
   public class TheseusWarRefPageView extends Sprite
   {
      
      public var _ref3from:TheseusWarIntensifyCell;
      
      public var _ref3Metrial:TheseusWarMetrailCell;
      
      public var _ref3Bg:Bitmap;
      
      public var _ref3Btn:IconButton;
      
      private var _replaceBtn:BaseButton;
      
      private var _pointBit:TextAddBitmap;
      
      private var _refreshBox:VBox;
      
      private var _refreshList:Array = [];
      
      private var _lockPoint:int;
      
      private var _oldTxt:FilterFrameText;
      
      private var _newtxt:FilterFrameText;
      
      private var _openPrams:Array = [1,4,8,10,15];
      
      public function TheseusWarRefPageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarRefineItem = null;
         var _loc3_:int = 0;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("warsoul_lock_point");
         if(_loc2_)
         {
            _lockPoint = int(_loc2_.ConfigValue);
         }
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("warsoul_clearopen_tips");
         if(_loc4_)
         {
            _openPrams = _loc4_.ConfigValue.split(",");
         }
         _ref3from = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.ref3from");
         _ref3Metrial = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.ref3Metrial");
         _ref3Bg = ComponentFactory.Instance.creatBitmap("asset.theseus.war.ref3Bg");
         _ref3Btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.ref3Btn");
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuswar.RefreshReplace");
         _refreshBox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.refreshVbox");
         _pointBit = ComponentFactory.Instance.creatCustomObject("ui.theseuswar.RefreshPointBit");
         _pointBit.initView("ui.theseus.refeshPoint","asset.core.SmallPointImg");
         _oldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.xl.oldText");
         _newtxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.xl.newText");
         addChild(_ref3from);
         addChild(_ref3Metrial);
         addChild(_ref3Bg);
         addChild(_ref3Btn);
         addChild(_pointBit);
         addChild(_replaceBtn);
         addChild(_refreshBox);
         addChild(_oldTxt);
         addChild(_newtxt);
         _pointBit.setText("0");
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 4;
         _ref3from.funType = 4;
         _ref3from.isNeedMediator = true;
         _oldTxt.text = LanguageMgr.GetTranslation("theseus.war.old");
         _newtxt.text = LanguageMgr.GetTranslation("theseus.war.new");
         _refreshBox.beginChanges();
         _refreshBox.removeAllChild();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new TheseusWarRefineItem();
            _refreshList[_loc3_] = _loc1_;
            _loc1_.baseSkId = -1;
            _loc1_.preSkId = -1;
            _refreshBox.addChild(_loc1_);
            _loc3_++;
         }
         _refreshBox.commitChanges();
         _ref3Btn.enable = false;
         _replaceBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         _ref3Btn.addEventListener("click",xilianBtnHandler);
         _replaceBtn.addEventListener("click",replaceHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_REFINE",updatePreViewHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseuswar.lockChange",lockChangeHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",refefshResult);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _ref3Btn.removeEventListener("click",xilianBtnHandler);
         _replaceBtn.removeEventListener("click",replaceHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_REFINE",updatePreViewHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseuswar.lockChange",lockChangeHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",refefshResult);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 0)
         {
            return;
         }
         if(_ref3Metrial.data)
         {
            _ref3Metrial.updateDataCount();
         }
      }
      
      private function lockChangeHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:TheseusWarRefineItem = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc2_ = _refreshList[_loc5_];
            if(_loc2_.selected)
            {
               _loc4_++;
            }
            _loc5_++;
         }
         var _loc3_:int = _loc4_ * _lockPoint;
         _pointBit.setText("" + _loc3_);
      }
      
      private function refefshResult(param1:NotificationEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:TheseusWarRefineItem = null;
         var _loc6_:int = 0;
         var _loc2_:int = int(param1.data);
         if(_loc2_ == 17 && _ref3from.data)
         {
            _loc4_ = _ref3from.data.ramdomSkills.split(",");
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               _loc5_ = int(_loc4_[_loc6_]);
               _loc3_ = _refreshList[_loc6_];
               _loc3_.baseSkId = _loc5_;
               _loc3_.preSkId = -1;
               if(_loc5_ <= 0)
               {
                  _loc3_.openLock(_openPrams[_loc6_]);
               }
               _loc6_++;
            }
         }
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _ref3from.data = null;
         _ref3Metrial.data = null;
         clearReList();
         _replaceBtn.enable = false;
         _ref3Btn.enable = false;
         _pointBit.setText("0");
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_);
            TheseussoulManager.Instance.doWarsoulParam(16,-1,_loc2_);
         }
      }
      
      private function clearReList() : void
      {
         var _loc1_:TheseusWarRefineItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _refreshList[_loc2_];
            _loc1_.baseSkId = -1;
            _loc1_.preSkId = -1;
            _loc2_++;
         }
      }
      
      private function updateUI(param1:int) : void
      {
         var _loc3_:TheseusWarRefineItem = null;
         var _loc5_:int = 0;
         var _loc9_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = _loc9_;
         _ref3from.data = _loc9_;
         _replaceBtn.enable = false;
         _pointBit.setText("0");
         var _loc7_:int = 0;
         clearReList();
         var _loc2_:Array = _loc9_.warTempInfo.ClearItem.split(",");
         var _loc8_:GoodsInfo = new GoodsInfo();
         _loc8_.templateId = int(_loc2_[0]);
         _loc8_.count = int(_loc2_[1]);
         _ref3Metrial.data = _loc8_;
         var _loc4_:Array = _loc9_.ramdomSkills.split(",");
         if(!_loc9_.warStartempInfo)
         {
            return;
         }
         var _loc6_:int = _loc9_.warStartempInfo.MaxClear - 1;
         _loc7_ = 0;
         while(_loc7_ < 5)
         {
            _loc5_ = int(_loc4_[_loc7_]);
            _loc3_ = _refreshList[_loc7_];
            _loc3_.baseSkId = _loc5_;
            if(_loc5_ <= 0 && _loc7_ > _loc6_)
            {
               _loc3_.openLock(_openPrams[_loc7_]);
            }
            _loc7_++;
         }
         _ref3Btn.enable = _loc9_.warStartempInfo.MaxClear > 0;
      }
      
      private function updatePreViewHandler(param1:Event) : void
      {
         var _loc2_:TheseusWarRefineItem = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:TheseusWarRfineInfo = TheseussoulManager.Instance.warsoulModel.refineInfo;
         if(_ref3from.data && _ref3from.data.id == _loc7_.id)
         {
            _loc3_ = _loc7_.skills;
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               _loc4_ = int(_loc3_[_loc6_]);
               _loc2_ = _refreshList[_loc6_];
               _loc2_.preSkId = _loc4_;
               if(_loc4_ > 0)
               {
                  _loc5_ = true;
               }
               _loc6_++;
            }
            _replaceBtn.enable = _loc5_;
         }
         else
         {
            _replaceBtn.enable = false;
         }
      }
      
      private function xilianBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:TheseusWarRefineItem = null;
         var _loc5_:int = 0;
         var _loc4_:Array = [0,0,0,0,0];
         var _loc3_:int = int(_refreshBox.numChildren);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _refreshList[_loc5_];
            if(_loc2_.selected)
            {
               _loc4_[_loc5_] = 1;
            }
            else
            {
               _loc4_[_loc5_] = 0;
            }
            _loc5_++;
         }
         if(_ref3from.data)
         {
            TheseussoulManager.Instance.doWarsoulParam(15,-1,_ref3from.data.id,-1,_loc4_);
         }
      }
      
      private function replaceHandler(param1:MouseEvent) : void
      {
         if(_ref3from.data)
         {
            TheseussoulManager.Instance.doWarsoulParam(17,-1,_ref3from.data.id);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_ref3from && _ref3from.data)
         {
            _ref3from.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_ref3from.data.id);
         }
         for each(var _loc1_:TheseusWarRefineItem in _refreshList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _refreshList = null;
         ObjectUtils.disposeObject(_ref3from);
         _ref3from = null;
         ObjectUtils.disposeObject(_ref3Metrial);
         _ref3Metrial = null;
         ObjectUtils.disposeObject(_ref3Bg);
         _ref3Bg = null;
         ObjectUtils.disposeObject(_ref3Btn);
         _ref3Btn = null;
         ObjectUtils.disposeObject(_replaceBtn);
         _replaceBtn = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         ObjectUtils.disposeObject(_refreshBox);
         _refreshBox = null;
         ObjectUtils.disposeObject(_oldTxt);
         _oldTxt = null;
         ObjectUtils.disposeObject(_newtxt);
         _newtxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
   }
}

