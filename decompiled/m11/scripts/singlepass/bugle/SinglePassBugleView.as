package singlepass.bugle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SinglePassEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.SinglePassManager;
   import managers.SinglePassSocketOutManager;
   import mvc.module.singlepass.SinglePassBugleInfo;
   import mvc.module.singlepass.SinglePassModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SinglePassBugleView extends Sprite
   {
      
      private var _model:SinglePassModel;
      
      private var _content:MovieClip;
      
      private var _startBtn:IconButton;
      
      private var _againBtn:IconButton;
      
      private var _bugleIconAsset:Image;
      
      private var _bugleCountTxt:FilterFrameText;
      
      private var _skipSelectedBtn:SelectedCheckButton;
      
      private var _skipTxtAsset:Bitmap;
      
      private var _itemDict:Dictionary;
      
      private var _currentIndex:int;
      
      private var _currentPointsCost:int;
      
      public function SinglePassBugleView()
      {
         super();
         _model = SinglePassManager.instance.model;
         _itemDict = new Dictionary(true);
         initView();
         initEvent();
         SinglePassSocketOutManager.sendRequestBugleOpen();
      }
      
      private function initView() : void
      {
         var _loc1_:SinglePassBugleItemView = null;
         var _loc3_:int = 0;
         _content = ComponentFactory.Instance.creatCustomObject("singlepass.bugle.ContentMc");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.StartBtn");
         _againBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.AgainBtn");
         _bugleIconAsset = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.BugleIcon");
         _bugleCountTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.BugleCountTxt");
         _skipSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.SkipBtn");
         _skipTxtAsset = ComponentFactory.Instance.creatBitmap("asset.singlepass.BugleSkipTxtAsset");
         _content.gotoAndStop(1);
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ <= 8)
         {
            _loc2_ = _loc3_ - 1;
            _loc1_ = new SinglePassBugleItemView();
            _loc1_.index = _loc3_;
            _content["pos_" + _loc3_].addChild(_loc1_);
            _itemDict[_loc2_] = _loc1_;
            _loc3_++;
         }
         addChild(_content);
         addChild(_startBtn);
         addChild(_againBtn);
         addChild(_bugleIconAsset);
         addChild(_bugleCountTxt);
         addChild(_skipSelectedBtn);
         addChild(_skipTxtAsset);
         _startBtn.visible = false;
         _againBtn.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_content);
         _content = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_againBtn);
         _againBtn = null;
         ObjectUtils.disposeObject(_bugleIconAsset);
         _bugleIconAsset = null;
         ObjectUtils.disposeObject(_bugleCountTxt);
         _bugleCountTxt = null;
         ObjectUtils.disposeObject(_skipSelectedBtn);
         _skipSelectedBtn = null;
         ObjectUtils.disposeObject(_skipTxtAsset);
         _skipTxtAsset = null;
         ObjectUtils.disposeAllChildren(this);
         _model = null;
      }
      
      private function initEvent() : void
      {
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _againBtn.addEventListener("click",__againBtnClickHandler);
         _model.addEventListener("UPDATE_BUGLE_INFO",__updateBugleInfoHandler);
         _model.addEventListener("UPDATE_BUGLE_REWARDS",__updateBugleRewardsHandler);
      }
      
      private function removeEvent() : void
      {
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         _againBtn.removeEventListener("click",__againBtnClickHandler);
         _model.removeEventListener("UPDATE_BUGLE_INFO",__updateBugleInfoHandler);
         _model.removeEventListener("UPDATE_BUGLE_REWARDS",__updateBugleRewardsHandler);
         if(_content)
         {
            _content.removeEventListener("complete",__showCompleteHandler);
            _content.removeEventListener("change",__completeHandler);
         }
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_skipSelectedBtn.selected)
         {
            playWash();
         }
         else
         {
            _content.gotoAndPlay("back_f");
         }
         _startBtn.enable = false;
      }
      
      private function playWash() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _itemDict)
         {
            _loc1_.playF2();
            _loc1_.buttonMode = true;
            _loc1_.addEventListener("click",__itemClickHandler);
         }
      }
      
      private function __againBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("022");
         SinglePassSocketOutManager.sendRequestBugleOpen();
         for each(_loc2_ in _itemDict)
         {
            _loc2_.playReversePre();
            _loc2_.resetCost();
            _loc2_.buttonMode = false;
            _loc2_.removeEventListener("click",__itemClickHandler);
         }
         _startBtn.enable = true;
         _currentIndex = 0;
         _currentPointsCost = 0;
      }
      
      private function __updateBugleInfoHandler(param1:SinglePassEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:GoodsInfo = null;
         var _loc2_:SinglePassBugleInfo = param1.data as SinglePassBugleInfo;
         var _loc4_:int = 0;
         for each(_loc3_ in _itemDict)
         {
            if(_loc2_.itemList[_loc4_])
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc2_.itemList[_loc4_].tempId;
               _loc5_.count = _loc2_.itemList[_loc4_].count;
               _loc3_.data = _loc5_;
               _loc3_.updateCost();
            }
            _loc4_++;
         }
         _content.addEventListener("complete",__showCompleteHandler);
         _content.addEventListener("change",__completeHandler);
         _content.gotoAndPlay("show_f");
         _startBtn.visible = true;
         _againBtn.visible = false;
         _bugleCountTxt.text = GoodsManager.instance.getGoodsNumByTempId(3150001).toString();
      }
      
      private function __updateBugleRewardsHandler(param1:SinglePassEvent) : void
      {
         var _loc3_:* = null;
         var _loc7_:GoodsInfo = null;
         var _loc2_:SinglePassBugleInfo = param1.data as SinglePassBugleInfo;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _currentPointsCost = _loc2_.needPoint;
         for each(_loc3_ in _itemDict)
         {
            _loc3_.updateCost(_currentPointsCost);
            _loc5_ = _loc3_.index;
            _loc6_ = int(_loc2_.openIndex.indexOf(_loc5_));
            if(_loc6_ != -1)
            {
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc2_.itemList[_loc6_].tempId;
               _loc7_.count = _loc2_.itemList[_loc6_].count;
               _loc3_.buttonMode = false;
               _loc3_.removeEventListener("click",__itemClickHandler);
               if(_loc5_ == _currentIndex)
               {
                  _loc3_.updateData(_loc7_);
               }
               else
               {
                  _loc3_.playF1();
               }
            }
         }
         if(_loc2_.openCount > 0)
         {
            _startBtn.visible = false;
            _againBtn.visible = true;
         }
         else
         {
            _startBtn.visible = true;
            _againBtn.visible = false;
         }
         var _loc4_:int = int(GoodsManager.instance.getGoodsNumByTempId(3150001));
         _startBtn.enable = _againBtn.enable = _loc4_ > 0;
         _bugleCountTxt.text = GoodsManager.instance.getGoodsNumByTempId(3150001).toString();
      }
      
      private function __showCompleteHandler(param1:Event) : void
      {
         _content.removeEventListener("complete",__showCompleteHandler);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _content.removeEventListener("change",__completeHandler);
         playWash();
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:Date = null;
         var _loc6_:int = 0;
         SoundManager.instance.play("007",true);
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(3150001));
         if(_loc3_ <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("singlepass.bugle.SinglePassBugleView.NoLeftCount");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:SinglePassBugleItemView = param1.currentTarget as SinglePassBugleItemView;
         _currentIndex = _loc4_.index;
         if(_currentPointsCost <= 0)
         {
            openCard(_currentIndex,true);
         }
         else
         {
            _loc5_ = SharedManager.instance.singlePassBugleOpenCardUseBindDate;
            if(SharedManager.instance.checkIsExpired(_loc5_))
            {
               showAlertFrame();
            }
            else
            {
               _loc6_ = int(playerInfo.point);
               if(SharedManager.instance.singlePassBugleOpenCardUseBind)
               {
                  _loc6_ = int(playerInfo.allPoint);
               }
               if(_loc6_ < _currentPointsCost)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               openCard(_currentIndex,SharedManager.instance.singlePassBugleOpenCardUseBind);
            }
         }
      }
      
      private function showAlertFrame() : void
      {
         var _loc3_:TodayNotAlertFrame = null;
         var _loc2_:String = null;
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc3_ = ComponentFactory.Instance.creatComponentByStylename("singlepass.RiverNotAlert");
         _loc2_ = LanguageMgr.GetTranslation("singlepass.bugle.SinglePassBugleView.OpenTips",_currentPointsCost);
         _loc3_.show(_loc2_,_loc1_,__todayNotAlertOpen,null,"center",2,true,_currentPointsCost);
      }
      
      private function __todayNotAlertOpen(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.singlePassBugleOpenCardUseBindDate = new Date();
            SharedManager.instance.singlePassBugleOpenCardUseBind = param2;
            SharedManager.instance.saveSinglePassBugleOpenCardUseBind();
            SharedManager.instance.saveSinglePassBugleOpenCardUseBindDate();
         }
         openCard(_currentIndex,param2);
      }
      
      private function openCard(param1:int, param2:Boolean) : void
      {
         SinglePassSocketOutManager.sendRequestBugleRoulette(param1,param2);
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

