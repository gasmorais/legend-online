package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.OthersTreasureInfo;
   import mvc.module.consortia.TreasureGroupInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureHelpView extends Component
   {
      
      private var _TxtImg1:Bitmap;
      
      private var _TxtImg2:Bitmap;
      
      private var _MiningTimeSprite:Sprite;
      
      private var _numBitmapData:BitmapData;
      
      private var _Helpvbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _ItemArr:Array;
      
      public function TreasureHelpView()
      {
         super();
         initView();
         initEvent();
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      private static function GoodsSortFuncDesc(param1:OthersTreasureInfo, param2:OthersTreasureInfo) : int
      {
         var _loc4_:ConsortiaTreasureTemplateInfo = null;
         var _loc3_:ConsortiaTreasureTemplateInfo = null;
         if(param1.status > param2.status)
         {
            return -1;
         }
         if(param1.status < param2.status)
         {
            return 1;
         }
         _loc4_ = ConsortiaManager.instance.getTreasureTempByID(param1.treasureTemplateId);
         _loc3_ = ConsortiaManager.instance.getTreasureTempByID(param2.treasureTemplateId);
         if(_loc4_.Quality > _loc3_.Quality)
         {
            return -1;
         }
         if(_loc4_.Quality < _loc3_.Quality)
         {
            return 1;
         }
         return 0;
      }
      
      private function initView() : void
      {
         _TxtImg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.HelpTxt1");
         _TxtImg2 = ComponentFactory.Instance.creatBitmap("asset.consortia.HelpTxt2");
         _MiningTimeSprite = ComponentFactory.Instance.creatCustomObject("consortia.Treasure.OpenTimeSprite");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.consortia.MiningTime");
         _Helpvbox = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasure.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasurePanel");
         _scrollPanel.setView(_Helpvbox);
         _ItemArr = [];
         addChild(_TxtImg1);
         addChild(_TxtImg2);
         addChild(_MiningTimeSprite);
         addChild(_scrollPanel);
      }
      
      private function __updataHelpHandler(param1:ConsortiaEvent) : void
      {
         var _loc4_:Object = null;
         var _loc5_:TreasureHelpItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(treasureGroupInfo.NoOpen)
         {
            _loc4_ = FrameControllerManager.instance["consortiaController"]["frame"];
            _loc4_.consortiaTreasurePage.gotoFrame(0);
            return;
         }
         clearVox();
         NumberViewUtils.refreshValue(model.treasureGroupInfo.helpLeftCount,_MiningTimeSprite,_numBitmapData,16,20,16,16,"0123456789");
         treasureGroupInfo.helpList.sort(GoodsSortFuncDesc);
         _loc2_ = 0;
         while(_loc2_ < treasureGroupInfo.helpList.length)
         {
            _loc5_ = new TreasureHelpItem();
            _loc5_.data = treasureGroupInfo.helpList[_loc2_];
            _Helpvbox.addChild(_loc5_);
            _ItemArr.push(_loc5_);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < treasureGroupInfo.helpList.length)
         {
            if(treasureGroupInfo.helpList[_loc3_].status == 1)
            {
               __allNormal();
            }
            _loc3_++;
         }
         selectID();
         refesh();
      }
      
      private function refesh() : void
      {
         _Helpvbox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         if(!_scrollPanel.hScrollbar)
         {
            return;
         }
         if(_Helpvbox.numChildren <= 3)
         {
            _scrollPanel.hScrollbar.visible = false;
         }
         else
         {
            _scrollPanel.hScrollbar.visible = true;
         }
      }
      
      public function reload() : void
      {
         if(treasureGroupInfo.NoOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasurNoOpen"));
            return;
         }
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      public function selectID() : void
      {
         var _loc1_:int = 0;
         if(treasureGroupInfo.helpOpenId > 0)
         {
            if(treasureGroupInfo.helpList.length > 3)
            {
               _loc1_ = 0;
               while(_loc1_ < treasureGroupInfo.helpList.length)
               {
                  if(treasureGroupInfo.helpOpenId == treasureGroupInfo.helpList[_loc1_].treasureId)
                  {
                     if(_loc1_ < treasureGroupInfo.helpList.length - 3)
                     {
                        _scrollPanel.displayObjectViewport.viewPosition.y = _loc1_ * 107;
                     }
                     else
                     {
                        _scrollPanel.invalidateViewport(true);
                     }
                     break;
                  }
                  _loc1_++;
               }
            }
            treasureGroupInfo.helpOpenId = -1;
         }
      }
      
      private function __allNormal() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = _ItemArr.length - 1;
         while(_loc2_ >= 0)
         {
            _ItemArr[_loc2_].noOpen = false;
            _loc2_--;
         }
      }
      
      private function __allOpen() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = _ItemArr.length - 1;
         while(_loc2_ >= 0)
         {
            _ItemArr[_loc2_].noOpen = true;
            _loc2_--;
         }
      }
      
      private function __removeItemHandle(param1:NotificationEvent) : void
      {
         __allOpen();
      }
      
      private function __openHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      private function __openTreasureHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("MYTREASURE_REMOVE",__removeItemHandle);
         ConsortiaManager.instance.model.addEventListener("OPEN_OTHERS_TREASURES",__updataHelpHandler);
         ConsortiaManager.instance.model.addEventListener("SPEED_UP",__openHandler);
         ConsortiaManager.instance.model.addEventListener("GET_REWARD",__openHandler);
         ConsortiaManager.instance.model.addEventListener("HELP_OPEN_TREASURE",__openTreasureHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("MYTREASURE_REMOVE",__removeItemHandle);
         ConsortiaManager.instance.model.removeEventListener("OPEN_OTHERS_TREASURES",__updataHelpHandler);
         ConsortiaManager.instance.model.removeEventListener("SPEED_UP",__openHandler);
         ConsortiaManager.instance.model.removeEventListener("GET_REWARD",__openHandler);
         ConsortiaManager.instance.model.removeEventListener("HELP_OPEN_TREASURE",__openTreasureHandler);
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get treasureGroupInfo() : TreasureGroupInfo
      {
         return ConsortiaManager.instance.model.treasureGroupInfo;
      }
      
      private function clearVox() : void
      {
         var _loc1_:TreasureHelpItem = null;
         var _loc2_:int = 0;
         if(_ItemArr.length == 0)
         {
            return;
         }
         _loc2_ = _ItemArr.length - 1;
         while(_loc2_ >= 0)
         {
            if(_ItemArr[_loc2_])
            {
               _ItemArr[_loc2_].dispose();
               _ItemArr[_loc2_] = null;
            }
            _ItemArr.pop();
            _loc2_--;
         }
         _loc1_ = null;
         if(_Helpvbox)
         {
            _Helpvbox.removeAllChild();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_TxtImg1)
         {
            ObjectUtils.disposeObject(_TxtImg1);
         }
         _TxtImg1 = null;
         if(_TxtImg2)
         {
            ObjectUtils.disposeObject(_TxtImg2);
         }
         _TxtImg2 = null;
         if(_MiningTimeSprite)
         {
            ObjectUtils.disposeObject(_MiningTimeSprite);
         }
         _MiningTimeSprite = null;
         if(_numBitmapData)
         {
            ObjectUtils.disposeObject(_numBitmapData);
         }
         _numBitmapData = null;
         if(_Helpvbox)
         {
            ObjectUtils.disposeObject(_Helpvbox);
         }
         _Helpvbox = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         LogicUtils.disposeDisplayCollection(_ItemArr);
         _ItemArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

