package funny.view
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.yy.game.encrypt.Base64;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import funny.FunnyHelper;
   import funny.activity.ActivityItem2;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyConditionData;
   import funny.datas.FunnyData;
   import funny.datas.FunnyRewardData;
   import funny.datas.FunnyType;
   import manager.LanguageMgr;
   import managers.ActivityManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   
   public class FunnyBagView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _rechargeBtn:IconButton;
      
      private var _readAllBtn:IconButton;
      
      private var _panel:ScrollPanel;
      
      private var _totalVBox:VBox;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<DisplayObject>;
      
      private var _title:GradientText;
      
      private var _describeText:FilterFrameText;
      
      private var _timeImage:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _conditionSprite:Sprite;
      
      private var _conditionImage:Bitmap;
      
      private var _condition:FilterFrameText;
      
      private var _processSprite:Sprite;
      
      private var _processImage:Bitmap;
      
      private var _process:FilterFrameText;
      
      private var _preSprite:Sprite;
      
      private var _preBack:Bitmap;
      
      private var _previewImage:Bitmap;
      
      private var _data:FunnyData;
      
      private var _txt:FilterFrameText;
      
      private var _outLinkDesc:FilterFrameText;
      
      private var _outlinkImgs:MultiImageSwitchView;
      
      public function FunnyBagView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagViewBack");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagView.rechargeBtn");
         _readAllBtn = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagView.readAllBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.title");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.describeText");
         _timeImage = ComponentFactory.Instance.creatBitmap("asset.funny.timeImage");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.timeText");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.remainTimeText");
         _conditionImage = ComponentFactory.Instance.creatBitmap("asset.funny.conditionImage");
         _condition = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.condition");
         _processImage = ComponentFactory.Instance.creatBitmap("asset.funny.processImage");
         _process = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.process");
         _preBack = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitleBack");
         _previewImage = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitle");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.itemVBox");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.totalVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.panel");
         _outLinkDesc = ComponentFactory.Instance.creatComponentByStylename("funny.outLinkDesc");
         _title.text = LanguageMgr.GetTranslation("funny.view.FunnyBagView.title");
         _conditionSprite = new Sprite();
         _conditionSprite.addChild(_conditionImage);
         _conditionSprite.addChild(_condition);
         _processSprite = new Sprite();
         _processSprite.addChild(_processImage);
         _processSprite.addChild(_process);
         _preSprite = new Sprite();
         _txt = new FilterFrameText();
         _preSprite.addChild(_txt);
         _preSprite.addChild(_preBack);
         _preSprite.addChild(_previewImage);
         addChild(_back);
         addChild(_rechargeBtn);
         addChild(_readAllBtn);
         _readAllBtn.visible = false;
         addChild(_title);
         addChild(_outLinkDesc);
         _outLinkDesc.visible = false;
         addChild(_panel);
         _panel.setView(_totalVBox);
         _itemList = new Vector.<DisplayObject>();
         addChild(_timeImage);
         addChild(_timeText);
         addChild(_remainTimeText);
      }
      
      public function get data() : FunnyData
      {
         return _data;
      }
      
      public function set data(param1:FunnyData) : void
      {
         var _loc14_:IntPoint = null;
         var _loc3_:IntPoint = null;
         var _loc7_:Array = null;
         var _loc18_:Dictionary = null;
         var _loc16_:Array = null;
         var _loc6_:String = null;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc15_:FunnyBagData = null;
         var _loc13_:* = undefined;
         var _loc2_:Array = null;
         var _loc17_:int = 0;
         var _loc4_:FunnyDoubleBagItem = null;
         var _loc9_:int = 0;
         var _loc5_:Boolean = false;
         var _loc10_:FunnyBagItem = null;
         var _loc11_:int = 0;
         if(_data == param1 && _panel && _panel.viewPort)
         {
            _loc3_ = _panel.viewPort.viewPosition;
            _loc14_ = new IntPoint(_loc3_.x,_loc3_.y);
         }
         else
         {
            _loc14_ = new IntPoint();
         }
         _data = param1;
         if(_data && _data.type == 1005)
         {
            return;
         }
         cleanView();
         if(param1 == null)
         {
            return;
         }
         if(_data.type == 186)
         {
            _outLinkDesc.htmlText = _data.describe;
            _readAllBtn.visible = _data.condition == "" ? false : true;
            _outLinkDesc.visible = true;
            _rechargeBtn.visible = false;
            _panel.visible = false;
            _remainTimeText.visible = false;
            if(!_outlinkImgs)
            {
               _loc7_ = [];
               _loc7_ = Base64.decode(_data.appendParam).split("|");
               _outlinkImgs = new MultiImageSwitchView(_loc7_);
               _outlinkImgs.x = 1;
               _outlinkImgs.y = 112;
               addChild(_outlinkImgs);
            }
            _outlinkImgs.visible = true;
         }
         else
         {
            _readAllBtn.visible = false;
            _outLinkDesc.visible = false;
            _rechargeBtn.visible = true;
            _panel.visible = true;
            _remainTimeText.visible = true;
            if(_outlinkImgs)
            {
               _outlinkImgs.visible = false;
            }
         }
         if(_data.type == 1003)
         {
            setRedeeming();
            return;
         }
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.itemVBox");
         _totalVBox.addChild(_describeText);
         _totalVBox.addChild(_conditionSprite);
         _conditionSprite.x = 5;
         if(FunnyType.isShowProcess(param1.type))
         {
            _totalVBox.addChild(_processSprite);
            _processSprite.x = 5;
            _process.text = FunnyHelper.processText(param1);
         }
         if(_data.type != 29 && _data.type != 43 && _data.type != 171)
         {
            _totalVBox.addChild(_preSprite);
            _totalVBox.addChild(_itemVBox);
         }
         _describeText.text = param1.describe;
         _condition.htmlText = param1.condition;
         setTimeText();
         if(_data.type == 16 || _data.type == 9 || _data.type == 1)
         {
            _loc18_ = new Dictionary();
            _loc16_ = [];
            _loc6_ = "";
            _loc8_ = 0;
            _loc12_ = 0;
            while(_loc12_ < param1.bagList.length)
            {
               _loc15_ = param1.bagList[_loc12_] as FunnyBagData;
               _loc13_ = _loc15_.conditionList;
               if(_loc6_ == param1.id + "_" + _loc13_[0].value + "_" + _loc13_[0].bak + "_" + _loc13_[0].bak2 + "_" + _loc13_[0].bak3 + "_" + _loc13_[0].bak4)
               {
                  _loc16_[_loc8_ - 1].push(_loc15_);
               }
               else
               {
                  _loc6_ = param1.id + "_" + _loc13_[0].value + "_" + _loc13_[0].bak + "_" + _loc13_[0].bak2 + "_" + _loc13_[0].bak3 + "_" + _loc13_[0].bak4;
                  _loc2_ = [];
                  _loc2_.push(_loc15_);
                  _loc16_[_loc8_] = _loc2_;
                  _loc8_++;
               }
               _loc12_++;
            }
            _loc17_ = 0;
            while(_loc17_ < _loc16_.length)
            {
               _loc4_ = new FunnyDoubleBagItem();
               _loc4_.data = _loc16_[_loc17_];
               _itemVBox.addChild(_loc4_);
               _loc17_++;
            }
         }
         else
         {
            _loc9_ = 0;
            _loc5_ = false;
            while(_loc9_ < param1.bagList.length)
            {
               _loc10_ = new FunnyBagItem();
               if(param1.type == 4)
               {
                  if(!param1.bagList[_loc9_].isShow || param1.bagList[_loc9_].status == 2)
                  {
                  }
               }
               else
               {
                  _loc10_.data = param1.bagList[_loc9_];
                  _itemVBox.addChild(_loc10_);
                  _itemList.push(_loc10_);
                  if(_loc10_.data.conditionList[0].id == 15)
                  {
                     _loc11_ = 0;
                     while(_loc11_ < _loc10_.data.conditionList.length)
                     {
                        if(_loc5_ || _loc10_.data.status == 1)
                        {
                           _loc5_ = true;
                           break;
                        }
                        if(_loc10_.data.conditionList[_loc11_].id == 15 && _loc10_.data.status == 3)
                        {
                           _loc10_.showRemainTime();
                           _loc5_ = true;
                        }
                        _loc11_++;
                     }
                  }
               }
               _loc9_++;
            }
         }
         _totalVBox.refreshChildPos();
         _panel.invalidateViewport();
         _panel.viewPort.viewPosition = _loc14_;
      }
      
      protected function __readAllBtnClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest(_data.condition);
         navigateToURL(_loc2_);
      }
      
      private function getIsMountConversion(param1:FunnyData) : Boolean
      {
         var _loc3_:int = 0;
         if(param1.bagList.length <= 0 || param1.bagList[0].conditionList.length <= 0)
         {
            return false;
         }
         var _loc2_:int = int(param1.bagList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.bagList[_loc3_].conditionList[0].bak == 2125073)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function getIsExchangeFishion(param1:FunnyData) : Boolean
      {
         var _loc3_:int = 0;
         if(param1.bagList.length <= 0 || param1.bagList[0].conditionList.length <= 0)
         {
            return false;
         }
         var _loc2_:int = int(param1.bagList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.bagList[_loc3_].conditionList[0].bak == 2125062)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function currentBag(param1:FunnyData) : FunnyBagData
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.bagList.length)
         {
            if(param1.bagList[_loc2_].status != 2 && param1.bagList[_loc2_].isShow)
            {
               return param1.bagList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function cleanView() : void
      {
         _describeText.text = "";
         _timeText.text = "";
         _remainTimeText.text = "";
         _condition.htmlText = "";
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         if(_totalVBox)
         {
            _totalVBox.disposeAllChildren();
         }
         cleanList();
         _panel.invalidateViewport();
      }
      
      private function setRedeeming() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActivityItem2 = null;
         _loc2_ = 0;
         while(_loc2_ < activityList.length)
         {
            if(_data.id == activityList[_loc2_].activeId)
            {
               _loc1_ = new ActivityItem2();
               _loc1_.activityTemplate = activityList[_loc2_];
               _totalVBox.addChild(_loc1_);
            }
            _loc2_++;
         }
         _totalVBox.refreshChildPos();
         _panel.invalidateViewport();
         _timeImage.visible = _timeText.visible = _remainTimeText.visible = false;
      }
      
      private function cleanList() : void
      {
         if(!_itemList)
         {
            return;
         }
         while(_itemList.length > 0)
         {
            _itemList.pop()["dispose"]();
         }
      }
      
      private function setTimeText() : void
      {
         _timeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.timeText",DateFormatter.getMonthDayString(_data.startTime),DateFormatter.getMonthDayString(_data.endTime));
         setRemainTime();
      }
      
      private function checkHasFashion(param1:FunnyBagData) : Boolean
      {
         var _loc3_:GoodsInfo = null;
         if(!param1)
         {
            return false;
         }
         for each(var _loc2_:FunnyRewardData in param1.rewardList)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.temId;
            _loc3_.count = _loc2_.count;
            _loc3_.isBinds = _loc2_.isBind;
            _loc3_.strengthenGrade = _loc2_.strengthenGrade <= 0 ? 1 : _loc2_.strengthenGrade;
            if(FrameControllerManager.instance.fashionCodeController.model.isFashion(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get activityList() : Array
      {
         return ActivityManager.Instance.activityList;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function setRemainTime() : void
      {
         if(!_data || _data.type == 1003)
         {
            return;
         }
         var _loc1_:Number = _data.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_data.startTime > playerModel.nowDate)
         {
            _timeImage.visible = _timeText.visible = true;
            _remainTimeText.visible = false;
         }
         else
         {
            _timeImage.visible = _timeText.visible = false;
            _remainTimeText.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__goodsUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__goodsUpdateHandler);
         if(_rechargeBtn)
         {
            _rechargeBtn.addEventListener("click",__rechargeHandler);
         }
         if(_readAllBtn)
         {
            _readAllBtn.addEventListener("click",__readAllBtnClickHandle);
         }
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__goodsUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__goodsUpdateHandler);
         if(_rechargeBtn)
         {
            _rechargeBtn.removeEventListener("click",__rechargeHandler);
         }
         if(_readAllBtn)
         {
            _readAllBtn.removeEventListener("click",__readAllBtnClickHandle);
         }
      }
      
      private function __rechargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __goodsUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_data)
         {
            return;
         }
         if(_data.type == 10)
         {
            _loc2_ = int(_data.bagList[0].conditionList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ > 0)
               {
                  _process.text += "," + FunnyHelper.getGoodsName(_data.bagList[0].conditionList[_loc3_].bak) + "*" + FunnyHelper.getBagCount(_data.bagList[0].conditionList[_loc3_].bak);
               }
               else
               {
                  _process.text = LanguageMgr.GetTranslation("funny.view.FunnyRightView.currentNum",FunnyHelper.getGoodsName(_data.bagList[0].conditionList[0].bak),FunnyHelper.getBagCount(_data.bagList[0].conditionList[0].bak));
               }
               _loc3_++;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanList();
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_totalVBox);
         _totalVBox = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_timeImage);
         _timeImage = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_conditionImage);
         _conditionImage = null;
         ObjectUtils.disposeObject(_condition);
         _condition = null;
         _conditionSprite = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_preBack);
         _preBack = null;
         ObjectUtils.disposeObject(_previewImage);
         _previewImage = null;
         _preSprite = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

