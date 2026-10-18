package marry.quality
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import marry.view.MarryRingView;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryQuality;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryConfirmFrame extends Frame implements IManualSize
   {
      
      private var _qualityIcon:ScaleFrameImage;
      
      private var _noblePriceText:GradientText;
      
      private var _commonPriceText:GradientText;
      
      private var _kiloPrice:Sprite;
      
      private var _priceBid:BitmapData;
      
      private var _bg:MutipleImage;
      
      private var _rewardBack:ScaleBitmapImage;
      
      private var _confirmBtn:IconButton;
      
      private var _quality:MarryQuality;
      
      private var _ringView:MarryRingView;
      
      private var _rewardItem2:BaseItemView;
      
      private var _rewardIcon3:BaseIconView;
      
      private var _rewardIcon4:BaseIconView;
      
      private var _rewardTxt1:FilterFrameText;
      
      private var _rewardTxt2:FilterFrameText;
      
      private var _rewardTxt3:FilterFrameText;
      
      private var _rewardTxt4:FilterFrameText;
      
      private var _rewardList:Array;
      
      private var _payTypeTxt:FilterFrameText;
      
      public function MarryConfirmFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,478,393);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame2.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.bg");
         _rewardBack = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.rewardBack");
         _qualityIcon = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.qualityIcon");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.ConfirmBtn");
         _noblePriceText = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.nobleIcon.PriceText");
         _commonPriceText = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.commonIcon.PriceText");
         _payTypeTxt = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.PayTypeTxt");
         _kiloPrice = new Sprite();
         _kiloPrice.x = 175;
         _kiloPrice.y = 126;
         addToContent(_bg);
         addToContent(_qualityIcon);
         addToContent(_rewardBack);
         addToContent(_kiloPrice);
         addToContent(_noblePriceText);
         addToContent(_commonPriceText);
         addToContent(_payTypeTxt);
         addToContent(_confirmBtn);
      }
      
      private function addReward() : void
      {
         var _loc2_:ThaneInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc3_:MarryTipData = null;
         _rewardList = [];
         _rewardItem2 = ComponentFactory.Instance.creatCustomObject("MarryConfirmFrame.rewardItem2");
         _rewardIcon3 = ComponentFactory.Instance.creatCustomObject("MarryConfirmFrame.rewardIcon3");
         _rewardTxt1 = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.rewardTxt1");
         _rewardTxt2 = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.rewardTxt2");
         _rewardTxt3 = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.rewardTxt3");
         addToContent(_rewardItem2);
         addToContent(_rewardIcon3);
         addToContent(_rewardTxt1);
         addToContent(_rewardTxt2);
         addToContent(_rewardTxt3);
         var _loc1_:MarryQualityData = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(_quality.qualityId);
         if(_loc1_)
         {
            _loc2_ = new ThaneInfo();
            _loc2_.marryRingGrade = _loc1_.RingGrade;
            _ringView = new MarryRingView(_loc2_);
            _ringView.width = 64;
            _ringView.height = 63;
            _ringView.x = 15;
            _ringView.y = 165;
            addToContent(_ringView);
         }
         if(_loc1_)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_.ClothId;
            _rewardItem2.data = _loc4_;
            _rewardItem2.icon.tipDirctions = "2,3,5,4";
         }
         if(_loc1_)
         {
            _loc3_ = new MarryTipData();
            _loc3_.type = 3;
            _loc3_.grades = _loc1_.RingGrade;
            _rewardIcon3.tipData = _loc3_;
            _rewardIcon3.icon = IconFactory.getMarrySkillByLevel(_loc1_.RingGrade);
         }
         if(_loc1_)
         {
            _noblePriceText.text = "" + _loc1_.Points;
         }
         if(_loc1_)
         {
            _commonPriceText.text = "" + _loc1_.Points;
         }
         _rewardTxt1.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt1");
         _rewardTxt2.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt5");
         _rewardTxt3.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt2");
         if(_ringView)
         {
            _rewardList.push(_ringView);
         }
         _rewardList.push(_rewardItem2);
         _rewardList.push(_rewardIcon3);
         _rewardList.push(_rewardTxt1);
         _rewardList.push(_rewardTxt2);
         _rewardList.push(_rewardTxt3);
         if(_quality.qualityId == 1 && _loc1_)
         {
            _rewardIcon4 = ComponentFactory.Instance.creatCustomObject("MarryConfirmFrame.rewardIcon4");
            _rewardIcon4.icon = IconFactory.getMarryHorseIcon();
            _rewardIcon4.tipData = LanguageMgr.GetTranslation("marry.quality.MarryKiloView.HorseIcon.tips");
            _rewardTxt4 = ComponentFactory.Instance.creatComponentByStylename("MarryConfirmFrame.rewardTxt4");
            _rewardTxt4.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt6");
            _priceBid = ComponentFactory.Instance.creatBitmapData("asset.marry.priceNum");
            addToContent(_rewardIcon4);
            addToContent(_rewardTxt4);
            _rewardList.push(_rewardIcon4);
            _rewardList.push(_rewardTxt4);
            NumberViewUtils.refreshValue(_loc1_.Points,_kiloPrice,_priceBid,17,27,14,17,"0123456789");
         }
         if(_loc1_)
         {
            setState();
         }
      }
      
      private function setState() : void
      {
         if(MarryManager.instance.model.isMarry)
         {
            if(_ringView)
            {
               _ringView.visible = false;
            }
            _rewardTxt1.visible = false;
            if(_rewardIcon4)
            {
               _rewardIcon4.x = _rewardIcon3.x;
               _rewardIcon4.y = _rewardIcon3.y;
               _rewardTxt4.x = _rewardTxt3.x;
               _rewardTxt4.y = _rewardTxt3.y;
            }
            _rewardIcon3.x = _rewardItem2.x;
            _rewardIcon3.y = _rewardItem2.y;
            _rewardTxt3.x = _rewardTxt2.x;
            _rewardTxt3.y = _rewardTxt2.y;
            _rewardItem2.x = 15;
            _rewardItem2.y = 165;
            _rewardTxt2.x = _rewardTxt1.x;
            _rewardTxt2.y = _rewardTxt1.y;
         }
         if(_quality.qualityId == 3)
         {
            _rewardItem2.visible = false;
            _rewardTxt2.visible = false;
            if(_rewardIcon4)
            {
               _rewardIcon4.x = _rewardIcon3.x;
               _rewardIcon4.y = _rewardIcon3.y;
               _rewardTxt4.x = _rewardTxt3.x;
               _rewardTxt4.y = _rewardTxt3.y;
            }
            _rewardIcon3.x = _rewardItem2.x;
            _rewardIcon3.y = _rewardItem2.y;
            _rewardTxt3.x = _rewardTxt2.x;
            _rewardTxt3.y = _rewardTxt2.y;
         }
      }
      
      private function clearList() : void
      {
         if(_rewardList)
         {
            while(_rewardList.length > 0)
            {
               _rewardList.pop().dispose();
            }
            _rewardList = null;
         }
      }
      
      private function refreshView() : void
      {
         if(_quality == null)
         {
            return;
         }
         _qualityIcon.setFrame(_quality.qualityId);
         switch(int(_quality.qualityId) - 1)
         {
            case 0:
               _noblePriceText.visible = false;
               _commonPriceText.visible = false;
               break;
            case 1:
               _noblePriceText.visible = true;
               _commonPriceText.visible = false;
               break;
            case 2:
               _noblePriceText.visible = false;
               _commonPriceText.visible = true;
               break;
            default:
               _noblePriceText.visible = false;
               _commonPriceText.visible = false;
         }
         if(_quality.payType == 2)
         {
            _payTypeTxt.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.PartPayTxt");
         }
         else
         {
            _payTypeTxt.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.SinglePayTxt");
         }
         addReward();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:MarryQualityData = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(_confirmBtn)
         {
            _confirmBtn.enable = false;
         }
         if(MarryManager.instance.model.isSingle)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.quality.MarryConfirmFrame.noLover"));
         }
         else if(_quality && _quality.opType == 4)
         {
            _loc4_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(_quality.qualityId);
            if(_loc4_ && _loc4_.Points / _quality.payType > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            MarrySender.buyQuality(_quality.qualityId,model.selfMarryInfo.userId,_quality.payType);
         }
         else if(_quality && _quality.opType == 5)
         {
            if(_quality.payType == 1)
            {
               MarrySender.qualityAnswer(true);
            }
            if(_quality.payType == 2)
            {
               SimpleAlertHelper.instance.data = [singlePayAlertBack];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.SinglePayAlertTxt");
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,false,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
               return;
            }
         }
         dispose();
      }
      
      private function singlePayAlertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MarrySender.qualityAnswer(true);
            dispose();
         }
         else if(_confirmBtn)
         {
            _confirmBtn.enable = true;
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            _quality = param1.frameData as MarryQuality;
            refreshView();
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         if(_quality && _quality.opType == 5)
         {
            MarrySender.qualityAnswer(false);
         }
         removeEvent();
         clearList();
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_qualityIcon)
         {
            _qualityIcon.dispose();
         }
         _qualityIcon = null;
         if(_noblePriceText)
         {
            _noblePriceText.dispose();
         }
         _noblePriceText = null;
         if(_commonPriceText)
         {
            _commonPriceText.dispose();
         }
         _commonPriceText = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_rewardBack)
         {
            _rewardBack.dispose();
         }
         _rewardBack = null;
         _quality = null;
         super.dispose();
      }
   }
}

