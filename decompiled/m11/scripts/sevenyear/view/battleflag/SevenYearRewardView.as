package sevenyear.view.battleflag
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.item.SevenYearRewardItem;
   import yishi.datas.templates.SevenYearRewardDropTemplate;
   import yishi.manager.TempleteManager;
   
   public class SevenYearRewardView extends Component
   {
      
      private var _bg:Image;
      
      private var _warn:Image;
      
      private var _leftBtn:IconButton;
      
      private var _rightBtn:IconButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _hBox:HBox;
      
      private var _itemList:Vector.<SevenYearRewardItem>;
      
      private var _returnTxt:TextButton;
      
      private var _receiveTxt:TextButton;
      
      private var SHOW_NUM:int = 70;
      
      private var ADD_NUM:int = 12;
      
      private var isMove:Boolean = false;
      
      private var _leftIndex:int = 0;
      
      private var _rightIndex:int = 0;
      
      private var isMin:Boolean = false;
      
      private var isMax:Boolean = false;
      
      private var oldGrade:int = -1;
      
      private var oldRewardGrade:int;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _freeBmp:Bitmap;
      
      private var _pointBmp:Bitmap;
      
      private var _arr:Array = [];
      
      private var _freeArr:Array = [];
      
      private var _dropTemp:SevenYearRewardDropTemplate;
      
      private var _freeDropTemp:SevenYearRewardDropTemplate;
      
      private var _sgBox:HBox;
      
      private var _sgItemList:Array = [];
      
      private var _sgChooseGrade:int = -1;
      
      private var _sgSpeed:int;
      
      private var _currSgChoose:SelectedTextButton;
      
      public function SevenYearRewardView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc5_:SelectedTextButton = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.bg");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.rightBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.scrollPanel");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.hBox");
         _returnTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.returnTxtBtn");
         _receiveTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardView.receiveTxtBtn");
         _freeBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearRewardView.free");
         _pointBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearRewardView.point");
         _warn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.warn");
         _warn.tipData = LanguageMgr.GetTranslation("sevenyear.honerLv.tip");
         _sgBox = ComponentFactory.Instance.creatComponentByStylename("sevenyear.SelectedTextButtonHbox");
         addChild(_bg);
         addChild(_hBox);
         addChild(_freeBmp);
         addChild(_pointBmp);
         _scrollPanel.setView(_hBox);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
         addChild(_warn);
         addChild(_leftBtn);
         addChild(_rightBtn);
         addChild(_returnTxt);
         addChild(_receiveTxt);
         addChild(_sgBox);
         _sgBox.beginChanges();
         var _loc2_:int = max;
         _sgSpeed = _loc2_ / 5;
         SHOW_NUM = _sgSpeed;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("sevenyear.SelectedTextButton");
            _loc1_ = 1 + _loc3_ * _sgSpeed;
            _loc4_ = (_loc3_ + 1) * _sgSpeed;
            _loc5_.text = _loc1_ + "-" + _loc4_;
            _loc5_.name = "" + _loc1_;
            _sgItemList[_loc3_] = _loc5_;
            _sgBox.addChild(_loc5_);
            _loc3_++;
         }
         _sgBox.commitChanges();
         _receiveTxt.visible = false;
         _returnTxt.text = LanguageMgr.GetTranslation("SevenYearRewardView.returnTxt.text");
         _itemList = new Vector.<SevenYearRewardItem>();
         _effect = new MainToolBtnGlowEffect(_receiveTxt);
         _effect.stop();
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:SevenYearRewardItem = null;
         _loc3_ = curGrade;
         var _loc1_:int = _loc3_ / _sgSpeed;
         var _loc5_:SelectedTextButton = _sgItemList[_loc1_];
         if(_loc5_)
         {
            doSelectItem(_loc5_);
         }
         if(_loc3_ == oldGrade && _loc3_ < max && _loc3_ != 0)
         {
            moveTarget();
            return;
         }
         oldGrade = _loc3_;
         _scrollPanel.beginChanges();
         _hBox.removeAllChild();
         clearList();
         _itemList = new Vector.<SevenYearRewardItem>();
         _loc4_ = curIndex;
         while(_loc4_ <= endIndex)
         {
            _arr = getTempArr(_loc4_);
            _dropTemp = _arr[0];
            _freeArr = getFreeTempArr(_loc4_);
            _freeDropTemp = _freeArr[0];
            _loc2_ = new SevenYearRewardItem(_dropTemp.para2,_freeDropTemp.para2);
            _loc2_.data(_arr,_freeArr,_dropTemp.site);
            _hBox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _leftIndex = curIndex;
         _rightIndex = endIndex;
         isMin = false;
         isMax = false;
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         moveTarget();
      }
      
      private function get isHaveItem() : Boolean
      {
         var _loc2_:Boolean = false;
         for each(var _loc1_:SevenYearRewardItem in _itemList)
         {
            if(_loc1_.grade == curGrade)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      private function moveTarget() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = int(curGrade > 0 ? curGrade : 1);
         for each(var _loc1_:SevenYearRewardItem in _itemList)
         {
            if(_loc1_.grade == _loc4_)
            {
               _loc5_ = _scrollPanel.width - _hBox.width;
               _loc3_ = -_loc1_.x + _scrollPanel.width / 2;
               if(_loc5_ > _loc3_)
               {
                  _loc2_ = _loc5_;
               }
               else if(_loc3_ < 0)
               {
                  _loc2_ = _loc3_;
               }
               else
               {
                  _loc2_ = 0;
               }
               _hBox.x = _loc2_;
               break;
            }
         }
         var _loc8_:int = Math.min(model.flagGrade,max);
         if(_loc8_ > model.rewardGrade)
         {
            _loc6_ = 0;
            _loc7_ = model.rewardGrade + 1;
            while(_loc7_ <= _loc8_)
            {
               if(model.rewardFreeGrade < _loc7_)
               {
                  _freeArr = getFreeTempArr(_loc7_);
                  _freeDropTemp = _freeArr[0];
                  if(_freeDropTemp.para2 != 0)
                  {
                     _loc6_++;
                  }
               }
               if(model.hasBuy)
               {
                  _arr = getTempArr(_loc7_);
                  _dropTemp = _arr[0];
                  if(_dropTemp.para2 != 0)
                  {
                     _loc6_++;
                  }
               }
               _loc7_++;
            }
            if(_loc6_ > 0)
            {
               _receiveTxt.visible = true;
               _receiveTxt.text = LanguageMgr.GetTranslation("SevenYearRewardView.receiveTxt.text",_loc6_);
               _effect.play();
            }
            else
            {
               _receiveTxt.visible = false;
               _effect.stop();
            }
         }
         else
         {
            _receiveTxt.visible = false;
            _effect.stop();
         }
         _returnTxt.visible = !_receiveTxt.visible;
         refreshItem();
         refreshLock();
      }
      
      private function refreshItem() : void
      {
         for each(var _loc1_:SevenYearRewardItem in _itemList)
         {
            _loc1_.refreshReceive();
         }
      }
      
      private function refreshLock() : void
      {
         for each(var _loc1_:SevenYearRewardItem in _itemList)
         {
            _loc1_.lock.visible = !model.hasBuy;
         }
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__leftBtnClickHandler);
         _rightBtn.addEventListener("click",__rightBtnClickHandler);
         addEventListener("mouseWheel",__onMouseWheel,true);
         _returnTxt.addEventListener("click",__returnTxtClickHandler);
         _receiveTxt.addEventListener("click",__receiveTxtClickHandler);
         for each(var _loc1_:SelectedTextButton in _sgItemList)
         {
            _loc1_.addEventListener("click",itemClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_leftBtn)
         {
            _leftBtn.removeEventListener("click",__leftBtnClickHandler);
         }
         if(_rightBtn)
         {
            _rightBtn.removeEventListener("click",__rightBtnClickHandler);
         }
         removeEventListener("mouseWheel",__onMouseWheel,true);
         if(_returnTxt)
         {
            _returnTxt.removeEventListener("click",__returnTxtClickHandler);
         }
         if(_receiveTxt)
         {
            _receiveTxt.removeEventListener("click",__receiveTxtClickHandler);
         }
         for each(var _loc1_:SelectedTextButton in _sgItemList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      private function itemClickHandler(param1:Event) : void
      {
         var _loc2_:SelectedTextButton = param1.currentTarget as SelectedTextButton;
         if(_currSgChoose == _loc2_)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.name);
         _sgChooseGrade = _loc3_;
         refreshView();
      }
      
      private function doSelectItem(param1:SelectedTextButton) : void
      {
         if(_currSgChoose == param1)
         {
            return;
         }
         _currSgChoose = param1;
         for each(var _loc2_:SelectedTextButton in _sgItemList)
         {
            if(_loc2_ == param1)
            {
               _loc2_.selected = true;
            }
            else
            {
               _loc2_.selected = false;
            }
         }
      }
      
      private function __returnTxtClickHandler(param1:MouseEvent) : void
      {
         _sgChooseGrade = -1;
         refreshView();
      }
      
      private function __receiveTxtClickHandler(param1:MouseEvent) : void
      {
         SevenYearManager.instance.sendOp(4);
      }
      
      private function __onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         param1.stopPropagation();
         if(isMove)
         {
            return;
         }
         isMove = true;
         if(param1.delta > 0)
         {
            _loc2_ = Math.min(0,_hBox.x + _scrollPanel.width / 5);
            _hBox.x = _loc2_;
            addLeftItem();
         }
         else
         {
            _loc3_ = _scrollPanel.width - _hBox.width;
            _loc2_ = Math.max(_loc3_,_hBox.x - _scrollPanel.width / 5);
            _hBox.x = _loc2_;
            addRightItem();
         }
         refreshItem();
         isMove = false;
      }
      
      private function __leftBtnClickHandler(param1:MouseEvent) : void
      {
         if(_itemList.length == 0)
         {
            return;
         }
         if(isMove)
         {
            return;
         }
         if(_hBox.x == 0)
         {
            return;
         }
         isMove = true;
         var _loc2_:int = Math.min(0,_hBox.x + _scrollPanel.width / 3);
         TweenLite.to(_hBox,0.2,{
            "x":_loc2_,
            "ease":Linear.easeOut,
            "onComplete":complete,
            "onCompleteParams":[_hBox,0]
         });
      }
      
      private function complete(param1:HBox, param2:int) : void
      {
         TweenLite.killTweensOf(param1);
         if(param2 == 0)
         {
            addLeftItem();
         }
         else
         {
            addRightItem();
         }
         refreshItem();
         isMove = false;
      }
      
      private function addLeftItem() : void
      {
         var _loc4_:int = 0;
         var _loc1_:SevenYearRewardItem = null;
         if(isMin)
         {
            return;
         }
         var _loc2_:int = int(_hBox.width);
         var _loc3_:int = int(_hBox.x);
         _loc4_ = _leftIndex - 1;
         while(_loc4_ >= _leftIndex - ADD_NUM)
         {
            if(_loc4_ < 1)
            {
               isMin = true;
               break;
            }
            _arr = getTempArr(_loc4_);
            _dropTemp = _arr[0];
            _freeArr = getFreeTempArr(_loc4_);
            _freeDropTemp = _freeArr[0];
            _loc1_ = new SevenYearRewardItem(_dropTemp.para2,_freeDropTemp.para2);
            _loc1_.data(_arr,_freeArr,_dropTemp.site);
            _hBox.isReverAdd = true;
            _hBox.addChild(_loc1_);
            _itemList.unshift(_loc1_);
            _loc4_--;
         }
         _hBox.isReverAdd = false;
         _hBox.x = _loc2_ - _hBox.width + _loc3_;
         _leftIndex -= ADD_NUM;
      }
      
      private function addRightItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SevenYearRewardItem = null;
         if(isMax)
         {
            return;
         }
         _loc2_ = _rightIndex + 1;
         while(_loc2_ <= _rightIndex + ADD_NUM)
         {
            if(_loc2_ > max)
            {
               isMax = true;
               break;
            }
            _arr = getTempArr(_loc2_);
            _dropTemp = _arr[0];
            _freeArr = getFreeTempArr(_loc2_);
            _freeDropTemp = _freeArr[0];
            _loc1_ = new SevenYearRewardItem(_dropTemp.para2,_freeDropTemp.para2);
            _loc1_.data(_arr,_freeArr,_dropTemp.site);
            _hBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _rightIndex += ADD_NUM;
      }
      
      private function __rightBtnClickHandler(param1:MouseEvent) : void
      {
         if(_itemList.length == 0)
         {
            return;
         }
         if(isMove)
         {
            return;
         }
         var _loc3_:int = _scrollPanel.width - _hBox.width;
         if(_hBox.x == _loc3_)
         {
            return;
         }
         isMove = true;
         var _loc2_:int = Math.max(_loc3_,_hBox.x - _scrollPanel.width / 3);
         TweenLite.to(_hBox,0.2,{
            "x":_loc2_,
            "ease":Linear.easeOut,
            "onComplete":complete,
            "onCompleteParams":[_hBox,1]
         });
      }
      
      private function clearList() : void
      {
         for each(var _loc1_:SevenYearRewardItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      private function get curGrade() : int
      {
         if(_sgChooseGrade >= 0)
         {
            return Math.min(_sgChooseGrade,max);
         }
         return Math.min(model.flagGrade,max);
      }
      
      private function get curIndex() : int
      {
         var _loc1_:int = curGrade - SHOW_NUM / 2;
         return int(_loc1_ <= 0 ? 1 : _loc1_);
      }
      
      private function get endIndex() : int
      {
         return Math.min(max,curIndex + SHOW_NUM);
      }
      
      private function get max() : int
      {
         return TempleteManager.instance.sevenYearRewardDropCate.getTemplates().keys.length;
      }
      
      private function getTempArr(param1:int) : Array
      {
         return TempleteManager.instance.sevenYearRewardDropCate.getTemplatesByGrade(param1);
      }
      
      private function getFreeTempArr(param1:int) : Array
      {
         return TempleteManager.instance.sevenYearFreeRewardDropCate.getTemplatesByGrade(param1);
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearList();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_returnTxt);
         _returnTxt = null;
         ObjectUtils.disposeObject(_receiveTxt);
         _receiveTxt = null;
         ObjectUtils.disposeAllChildren(_warn);
         _warn = null;
         ObjectUtils.disposeObject(_sgBox);
         _sgBox = null;
         for each(var _loc1_:SelectedTextButton in _sgItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _sgItemList = null;
         _effect = null;
         _currSgChoose = null;
         super.dispose();
      }
   }
}

