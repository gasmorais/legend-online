package funny.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import funny.FunnyHelper;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyRewardData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class FunnyBagItem extends Sprite implements Disposeable
   {
      
      private var _title:FilterFrameText;
      
      private var _rewardList:SimpleTileList;
      
      private var _hasGet:Bitmap;
      
      private var _getBtn:IconButton;
      
      private var _payBtn:IconButton;
      
      private var _data:FunnyBagData;
      
      private var _filters:UIFilter;
      
      private var _remainBack:Bitmap;
      
      private var _remainTime:FilterFrameText;
      
      private var _payBtnShow:Boolean = false;
      
      private var _txt:FilterFrameText;
      
      private var _canGetImage:Image;
      
      private var _canGetText:FilterFrameText;
      
      public function FunnyBagItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.title");
         _rewardList = ComponentFactory.Instance.creatCustomObject("funnyRewardItem.rewardTileList");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.getBtn");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.payBtn");
         _remainBack = ComponentFactory.Instance.creatBitmap("asset.funny.getBack1");
         _remainTime = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.remainTime");
         _canGetImage = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.canGetImage");
         _canGetText = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.canGetText");
         _txt = new FilterFrameText();
         _txt.y = 76;
         addChild(_title);
         addChild(_rewardList);
         addChild(_hasGet);
         addChild(_getBtn);
         addChild(_payBtn);
         addChild(_remainBack);
         addChild(_remainTime);
         addChild(_canGetImage);
         addChild(_canGetText);
         addChild(_txt);
         _filters = new UIFilter();
         _hasGet.x = 400;
         _hasGet.y = 21;
         _hasGet.visible = false;
         _getBtn.enable = false;
         _payBtn.visible = false;
         _remainBack.visible = false;
         _remainTime.visible = false;
         _canGetText.visible = false;
         _canGetImage.visible = false;
         _remainBack.x = 392;
         _remainBack.y = 36;
         _filters.setGrayFilter(_remainBack);
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc5_:StarInfo = null;
         var _loc7_:StarBagCell = null;
         var _loc6_:MovieImage = null;
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         if(hasFashion)
         {
            _rewardList.column = 5;
         }
         else
         {
            _rewardList.column = 7;
         }
         _rewardList.disposeAllChildren();
         _rewardList.beginChanges();
         if(param1.conditionList[0].id == 11)
         {
            _getBtn.backStyle = "asset.funny.getBack1";
            _getBtn.iconStyle = "asset.funny.ItemButtonMc1";
            _getBtn.iconInnerRectString = "22,46,6,22,13";
            _canGetImage.visible = false;
            _canGetText.visible = false;
            if(_data.getCount > 0)
            {
               _canGetImage.visible = true;
               _canGetText.visible = true;
               _canGetText.text = _data.getCount.toString();
               _getBtn.iconInnerRectString = "32,46,6,22,13";
            }
         }
         else
         {
            _getBtn.backStyle = "asset.core.Style24Btn";
            _getBtn.iconStyle = "asset.funny.getIcon";
            _getBtn.iconInnerRectString = "22,46,7,21,13";
         }
         var _loc10_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _data.rewardList.length)
         {
            if(_data.rewardList[_loc3_].temType == 1)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _data.rewardList[_loc3_].temId;
               _loc4_.count = _data.rewardList[_loc3_].count;
               _loc4_.showCount = true;
               _loc4_.isBinds = _data.rewardList[_loc3_].isBind;
               _loc4_.strengthenGrade = _data.rewardList[_loc3_].strengthenGrade;
               _loc2_.data = _loc4_;
               if(filterEquip(_loc4_))
               {
                  _rewardList.addChild(_loc2_);
                  _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.rewardList[_loc3_].temId);
                  if(_loc9_ && _loc9_.Profile >= 5)
                  {
                     _loc10_.push(_loc2_);
                  }
               }
            }
            else if(_data.rewardList[_loc3_].temType == 2)
            {
               _loc5_ = new StarInfo();
               _loc5_.template = TempleteManager.instance.starTempalteCate.getTemplateByID(_data.rewardList[_loc3_].temId);
               _loc5_.count = _data.rewardList[_loc3_].count;
               _loc5_.grade = _data.rewardList[_loc3_].strengthenGrade <= 0 ? 1 : _data.rewardList[_loc3_].strengthenGrade;
               if(filterStar(_loc5_))
               {
                  _loc7_ = ComponentFactory.Instance.creatCustomObject("funnyBagItem.StarBagCell");
                  _loc7_.data = _loc5_;
                  _loc7_.acceptDrop = false;
                  _loc7_.lock = false;
                  _rewardList.addChild(_loc7_);
               }
            }
            _loc3_++;
         }
         _rewardList.commitChanges();
         for each(var _loc8_:BaseItemView in _loc10_)
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("funny.LightEffect");
            _loc6_.mouseEnabled = false;
            _loc6_.mouseChildren = false;
            _loc6_.x = _loc8_.x + 26;
            _loc6_.y = _loc8_.y - 8;
            addChild(_loc6_);
         }
         _loc10_ = null;
         setState();
         _title.htmlText = _data.title;
         _title.numLines == 2 ? (_title.y = -10) : (_title.y = 3);
      }
      
      private function filterStar(param1:StarInfo) : Boolean
      {
         if(!param1 || !param1.template)
         {
            return false;
         }
         if(param1.template.Job.indexOf("0") >= 0)
         {
            return true;
         }
         return true;
      }
      
      public function filterEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = ThaneInfoHelper.getJob(ArmyManager.instance.thane.job);
         if(param1.templateInfo.Job == "0" || param1.templateInfo.Job.indexOf(_loc2_ + "") != -1 || param1.templateInfo.Job == "99")
         {
            return true;
         }
         return false;
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      public function setState() : void
      {
         var _loc1_:int = 0;
         if(_data == null)
         {
            return;
         }
         switch(_data.status - 1)
         {
            case 0:
               _filters.setNormalFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = true;
               }
               if(_payBtn)
               {
                  _payBtn.visible = false;
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
               hideRemainTime();
               break;
            case 1:
               _filters.setGrayFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = true;
               }
               if(_getBtn)
               {
                  _getBtn.visible = false;
               }
               if(_payBtn)
               {
                  _payBtn.visible = false;
               }
               if(_title)
               {
                  _title.setFrame(1);
               }
               hideRemainTime();
               break;
            case 2:
               _filters.setNormalFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
               }
               if(_data.conditionList[0].id == 3)
               {
                  _payBtn.visible = true;
                  _getBtn.visible = false;
                  _loc1_ = _data.conditionList[0].value - FunnyManager.instance.selectedFunnyData.canGet;
                  _payBtn.tipData = LanguageMgr.GetTranslation("funny.view.FunnyBagItem.PayBtn.TipTxt",_loc1_);
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:FunnyMutiFrame = null;
         if(_data.activeId == "REGRESS_ID")
         {
            FunnyManager.instance.sendReturnOption(1,_data.order);
            return;
         }
         if(FunnyManager.instance.selectedFunnyData.endTime <= PlayerManager.instance.currentPlayerModel.nowDate)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         if(FunnyHelper.isMutConditionType(_data) && FunnyManager.instance.selectedFunnyData.getWay == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("funny.view.FunnyMutiFrame");
            _loc2_.data = _data;
            _loc2_.show();
         }
         else
         {
            FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
         }
      }
      
      private function __payBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function showRemainTime() : void
      {
         if(_data && _data.remainTime > 0)
         {
            _remainBack.visible = true;
            _remainTime.visible = true;
            _remainTime.text = DateFormatter.getFullDateString(_data.remainTime);
            PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timerHandler);
         }
      }
      
      public function showPayBtn() : void
      {
         _payBtnShow = true;
      }
      
      public function hideRemainTime() : void
      {
         _remainBack.visible = false;
         _remainTime.visible = false;
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timerHandler);
      }
      
      private function __timerHandler(param1:Event) : void
      {
         _data.remainTime -= 1;
         if(_data && _data.remainTime > 0)
         {
            _remainBack.visible = true;
            _remainTime.visible = true;
            _remainTime.text = DateFormatter.getFullDateString(_data.remainTime);
         }
         else
         {
            _remainBack.visible = false;
            _remainTime.visible = false;
            PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timerHandler);
            FunnyManager.instance.sendGetBag(1);
         }
      }
      
      private function __wearBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:ShopGoodsInfo = null;
         var _loc7_:GoodsTemplateInfo = null;
         if(!hasFashion)
         {
            return;
         }
         var _loc3_:Array = [];
         var _loc6_:Vector.<GoodsTemplateInfo> = new Vector.<GoodsTemplateInfo>();
         var _loc4_:Vector.<ShopGoodsInfo> = new Vector.<ShopGoodsInfo>();
         _loc6_.push(null);
         _loc6_.push(null);
         _loc6_.push(null);
         _loc6_.push(null);
         for each(var _loc2_:FunnyRewardData in _data.rewardList)
         {
            if(isFashion(_loc2_))
            {
               _loc5_ = TempleteManager.instance.getShopTempInfoByItemId(_loc2_.temId);
               _loc4_.push(_loc5_);
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.temId);
               if(_loc7_.SonType == 109)
               {
                  _loc6_[0] = _loc7_;
               }
               else if(_loc7_.SonType == 111)
               {
                  _loc6_[1] = _loc7_;
               }
               else if(_loc7_.SonType == 112)
               {
                  _loc6_[2] = _loc7_;
               }
               else if(_loc7_.SonType == 110)
               {
                  _loc6_[3] = _loc7_;
               }
            }
         }
         FrameControllerManager.instance.openControllerByInfo("shop",9,[_loc6_,null,buyWingFunction]);
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("funny.view.FunnyBagItem.cannotBuy"));
      }
      
      private function isFashion(param1:FunnyRewardData) : Boolean
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.temId;
         _loc2_.count = param1.count;
         _loc2_.isBinds = param1.isBind;
         _loc2_.strengthenGrade = param1.strengthenGrade <= 0 ? 1 : param1.strengthenGrade;
         if(fashionModel.isFashion(_loc2_))
         {
            return true;
         }
         return false;
      }
      
      private function get hasFashion() : Boolean
      {
         var _loc2_:GoodsInfo = null;
         if(!_data || _data.rewardList.length <= 0)
         {
            return false;
         }
         for each(var _loc1_:FunnyRewardData in _data.rewardList)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _loc1_.temId;
            _loc2_.count = _loc1_.count;
            _loc2_.isBinds = _loc1_.isBind;
            _loc2_.strengthenGrade = _loc1_.strengthenGrade <= 0 ? 1 : _loc1_.strengthenGrade;
            if(fashionModel.isFashion(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__clickHandler);
         }
         if(_payBtn)
         {
            _payBtn.addEventListener("click",__payBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
         if(_payBtn)
         {
            _payBtn.removeEventListener("click",__payBtnClickHandler);
         }
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timerHandler);
      }
      
      override public function get height() : Number
      {
         if(hasFashion && _data.rewardList.length > 5 || !hasFashion && _data.rewardList.length > 7)
         {
            return 140;
         }
         return 82;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _filters = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_rewardList);
         _rewardList = null;
         if(_hasGet)
         {
            _hasGet.filters = null;
         }
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         ObjectUtils.disposeObject(_remainBack);
         _remainBack = null;
         ObjectUtils.disposeObject(_remainTime);
         _remainTime = null;
         ObjectUtils.disposeObject(_canGetImage);
         _canGetImage = null;
         ObjectUtils.disposeObject(_canGetText);
         _canGetText = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

