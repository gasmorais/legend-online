package armyII.viewII.stone.view
{
   import armyII.viewII.stone.item.StoneGroupItem;
   import armyII.viewII.stone.ui.StoneDkUI;
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class StoneDkView extends StoneDkUI
   {
      
      private var _data:RuneInfo;
      
      private var _beforeItem:StoneGroupItem;
      
      private var _nextItem:StoneGroupItem;
      
      private var _bgLine1:ScaleBitmapImage;
      
      private var _bgLine2:ScaleBitmapImage;
      
      private var _bg1:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _neednum:int;
      
      private const DK_ID:int = 10010000;
      
      private var _isFirst:Boolean = true;
      
      public function StoneDkView()
      {
         beforeInit();
         super();
         init();
         initEvent();
      }
      
      private function beforeInit() : void
      {
         _neednum = TempleteManager.instance.getConfigValue("runehole_use");
         _bgLine1 = ComponentFactory.Instance.creatComponentByStylename("army.stoneDk.Back1");
         addChild(_bgLine1);
         _bgLine2 = ComponentFactory.Instance.creatComponentByStylename("army.stoneDk.Back2");
         addChild(_bgLine2);
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.army.stone.dkBag");
         addChild(_bg1);
         _bg1.x = 5;
         _bg1.y = 7;
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.army.stone.dkBag");
         addChild(_bg2);
         _bg2.x = 5;
         _bg2.y = 228;
      }
      
      private function init() : void
      {
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 10010000;
         _gIcon.tipData = _loc1_.templateInfo.Description;
         _beforeItem = new StoneGroupItem(2);
         _nextItem = new StoneGroupItem(2);
         addChild(_beforeItem);
         addChild(_nextItem);
         _beforeItem.x = 47;
         _beforeItem.y = 14;
         _nextItem.x = 47;
         _nextItem.y = 236;
      }
      
      private function initEvent() : void
      {
         _dkReplaceBtn.addEventListener("click",replaceHandler);
         _dkDkBtn.addEventListener("click",dkHandler);
         NotificationManager.instance.addEventListener("RUNE_UPGRADE",changeInfohandler);
         NotificationManager.instance.addEventListener("RUNE_NO_CHANGE",nochangeInfohandler);
         NotificationManager.instance.addEventListener("StonebagCell.EffectOver",effectOverHandler);
      }
      
      private function removeEvent() : void
      {
         _dkReplaceBtn.removeEventListener("click",replaceHandler);
         _dkDkBtn.removeEventListener("click",dkHandler);
         NotificationManager.instance.removeEventListener("RUNE_UPGRADE",changeInfohandler);
         NotificationManager.instance.removeEventListener("RUNE_NO_CHANGE",nochangeInfohandler);
         NotificationManager.instance.removeEventListener("StonebagCell.EffectOver",effectOverHandler);
      }
      
      private function effectOverHandler(param1:Event) : void
      {
         deleteBagHandler();
      }
      
      private function deleteBagHandler(param1:BagEvent = null) : void
      {
         if(!_dkDkBtn)
         {
            return;
         }
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(10010000));
         _dkNumTxt.text = LanguageMgr.GetTranslation("fish.FishFrame.countText",_loc2_,_neednum);
         if(_loc2_ < _neednum)
         {
            _dkNumTxt.setFrame(2);
            setDkState(false);
         }
         else
         {
            _dkNumTxt.setFrame(1);
            setDkState(true);
         }
      }
      
      private function nochangeInfohandler(param1:NotificationEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _nextItem.playOpenEffect(true);
      }
      
      private function changeInfohandler(param1:NotificationEvent) : void
      {
         var _loc2_:RuneInfo = param1.data as RuneInfo;
         if(!_data)
         {
            return;
         }
         if(!_loc2_)
         {
            return;
         }
         data = _loc2_;
         _nextItem.playOpenEffect(true);
      }
      
      private function replaceHandler(param1:MouseEvent) : void
      {
         if(_data == null || _data.runeTempHole == null && _data.runeTempHole.length <= 0)
         {
            return;
         }
         var _loc5_:Array = _data.runeHole.split("|");
         var _loc8_:Array = _loc5_[1].split(",");
         var _loc6_:Array = _data.runeTempHole.split("|");
         var _loc4_:Array = _loc6_[1].split(",");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc9_:String = LanguageMgr.GetTranslation("army.stone.replaceTip2");
         if(_loc4_.length < _loc8_.length)
         {
            _loc9_ = LanguageMgr.GetTranslation("army.stone.replaceTip1");
         }
         SimpleAlertHelper.instance.data = [__replaceResponse];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc9_,_loc2_,_loc3_,false,true);
      }
      
      private function __replaceResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ArmySocketOutManager.sendOpStoneRune(_data.runeId,7);
            NotificationManager.instance.sendNotification("StoneDkView.closeEvent");
         }
      }
      
      private function setDkState(param1:Boolean) : void
      {
         _dkDkBtn.enable = param1;
      }
      
      private function dkHandler(param1:MouseEvent) : void
      {
         var _loc10_:String = null;
         var _loc7_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc4_:String = null;
         if(_data == null)
         {
            return;
         }
         var _loc6_:Array = _data.runeHole.split("|");
         var _loc9_:Array = _loc6_[1].split(",");
         if(_data.runeTempHole != null && _data.runeTempHole.length > 0)
         {
            _loc7_ = _data.runeTempHole.split("|");
            _loc5_ = _loc7_[1].split(",");
            if(_loc5_.length > _loc9_.length && _loc5_.length >= 4)
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("public.prompt");
               _loc10_ = LanguageMgr.GetTranslation("army.stone.dkTIP",_loc5_.length);
               SimpleAlertHelper.instance.data = [__dkResponse];
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc10_,_loc2_,_loc3_,false,true);
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
               _loc10_ = LanguageMgr.GetTranslation("stone.dk.tip");
               SharedManagerHelper.ins.needAlert("view.stonedkview.dk",dkConfirm,_loc4_,_loc10_);
            }
         }
         else
         {
            setDkState(false);
            ArmySocketOutManager.sendOpStoneRune(_data.runeId,6);
         }
      }
      
      private function dkConfirm() : void
      {
         setDkState(false);
         ArmySocketOutManager.sendOpStoneRune(_data.runeId,6);
      }
      
      private function __dkResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            setDkState(false);
            ArmySocketOutManager.sendOpStoneRune(_data.runeId,6);
         }
      }
      
      public function set data(param1:RuneInfo) : void
      {
         var _loc2_:Boolean = false;
         _data = param1;
         if(_data)
         {
            _loc2_ = _data.runeTempHole != null && _data.runeTempHole.length > 0;
            _dkReplaceBtn.enable = _loc2_;
            _beforeItem.updateView(_data.runeHole,_data.templateInfo.RuneType);
            if(_loc2_)
            {
               _nextItem.visible = true;
               _nextItem.updateView(_data.runeTempHole,_data.templateInfo.RuneType);
            }
            else
            {
               _nextItem.visible = false;
            }
            if(_isFirst)
            {
               _isFirst = false;
               deleteBagHandler();
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_beforeItem);
         _beforeItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_bgLine1);
         _bgLine1 = null;
         ObjectUtils.disposeObject(_bgLine2);
         _bgLine2 = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         super.dispose();
         _data = null;
      }
   }
}

