package mounts
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.WildSoulInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.base.StarBar;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tools.SimpleMovie;
   
   public class MountsPromotionView extends Component
   {
      
      private var _leftBox:Component;
      
      private var _rightBox:Component;
      
      private var _leftBg:CustomBitmap;
      
      private var _rightBg:CustomBitmap;
      
      private var _separateLine:CustomBitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _leftStarBar:StarBar;
      
      private var _bodyBox:MountsAvatarView;
      
      private var _starGradeImg:CustomBitmap;
      
      private var _rightStarBar:StarBar;
      
      private var _propertyAddImg:CustomBitmap;
      
      private var _propertyBack:CustomBitmap;
      
      private var _blessImg:CustomBitmap;
      
      private var _blessBack:CustomBitmap;
      
      private var _blessBar:MovieClip;
      
      private var _blessTxt:FilterFrameText;
      
      private var _successImg:CustomBitmap;
      
      private var _successTxt:FilterFrameText;
      
      private var _promotBtn:IconButton;
      
      private var _advPromotBtn:BaseButton;
      
      private var _returnBtn:IconButton;
      
      private var _promotCountTxt:FilterFrameText;
      
      private var _CountTxt:Bitmap;
      
      private var _CountImg:Bitmap;
      
      private var _promotCount:int;
      
      private var _arrow:CustomBitmap;
      
      private var _vBox:VBox;
      
      private var _maxGradeImg:CustomBitmap;
      
      private const advCost:int = 10;
      
      private var _data:WildSoulInfo;
      
      private var lastGrade:int = 0;
      
      private var _lastStar:int = 0;
      
      public function MountsPromotionView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MountsPromotionItemView = null;
         _leftBox = new Component();
         _rightBox = new Component();
         _leftBox.mouseChildren = _leftBox.mouseEnabled = false;
         _rightBox.mouseEnabled = false;
         _rightBox.x = 294;
         _separateLine = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.separateLine");
         addChild(_separateLine);
         addChild(_leftBox);
         addChild(_rightBox);
         _leftBg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.leftBg");
         _rightBg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.rightBg");
         _leftBox.addChild(_leftBg);
         _rightBox.addChild(_rightBg);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.nameTxt");
         _leftStarBar = new StarBar(5,0,"asset.wildsoul.EmptyStarBig","asset.wildsoul.FullStarBig");
         _leftStarBar.y = 40;
         _leftStarBar.x = 155;
         _bodyBox = new MountsAvatarView();
         _bodyBox.x = 145;
         _bodyBox.y = 310;
         _leftBox.addChild(_nameTxt);
         _leftBox.addChild(_leftStarBar);
         _leftBox.addChild(_bodyBox);
         _starGradeImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.starGradeImg");
         _rightStarBar = new StarBar(5,0,"asset.wildsoul.EmptyStarBig","asset.wildsoul.FullStarBig");
         _rightStarBar.x = 200;
         _rightStarBar.y = 21;
         _propertyAddImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.propertyAddImg");
         _propertyBack = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.propertyBack");
         _blessImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.blessImg");
         _blessBack = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.blessBack");
         _blessBar = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.blessBar");
         _blessTxt = ComponentFactory.Instance.creatComponentByStylename("asset.promotion.BlessBarTxt");
         _successImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.successImg");
         _successTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.successTxt");
         _promotBtn = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.promotBtn");
         _advPromotBtn = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.advPromotBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.returnBtn");
         _CountTxt = ComponentFactory.Instance.creatBitmap("asset.promotion.CountTxt");
         _CountImg = ComponentFactory.Instance.creatBitmap("asset.promotion.CountImg");
         _promotCountTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotion.promotCountTxt");
         _rightBox.addChild(_starGradeImg);
         _rightBox.addChild(_rightStarBar);
         _rightBox.addChild(_propertyAddImg);
         _rightBox.addChild(_propertyBack);
         _rightBox.addChild(_blessImg);
         _rightBox.addChild(_blessBack);
         _rightBox.addChild(_blessBar);
         _rightBox.addChild(_blessTxt);
         _rightBox.addChild(_successImg);
         _rightBox.addChild(_successTxt);
         _rightBox.addChild(_promotBtn);
         _rightBox.addChild(_advPromotBtn);
         _rightBox.addChild(_returnBtn);
         _rightBox.addChild(_CountTxt);
         _rightBox.addChild(_CountImg);
         _CountImg.x = _CountTxt.x + _CountTxt.width + 3;
         _rightBox.addChild(_promotCountTxt);
         _promotCountTxt.x = _CountImg.x + _CountImg.width + 3;
         _arrow = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.arrow");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionView.vBox");
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new MountsPromotionItemView(_loc2_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _rightBox.addChild(_vBox);
         _rightBox.addChild(_arrow);
         _maxGradeImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionView.maxGradeImg");
         _rightBox.addChild(_maxGradeImg);
         _promotBtn.tipData = LanguageMgr.GetTranslation("mountsPromotionView.promotBtn.tip");
         _advPromotBtn.tipData = LanguageMgr.GetTranslation("mountsPromotionView.advpromotBtn.tip",10);
         _promotCount = GoodsManager.instance.goodsCountByTempId[208035];
         _promotCountTxt.text = "x " + _promotCount.toString();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_blessTxt);
         _blessTxt = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_promotBtn);
         _promotBtn = null;
         ObjectUtils.disposeObject(_advPromotBtn);
         _advPromotBtn = null;
         ObjectUtils.disposeObject(_successTxt);
         _successTxt = null;
         ObjectUtils.disposeObject(_successImg);
         _successImg = null;
         ObjectUtils.disposeObject(_blessBar);
         _blessBar = null;
         ObjectUtils.disposeObject(_blessBack);
         _blessBack = null;
         ObjectUtils.disposeObject(_blessImg);
         _blessImg = null;
         ObjectUtils.disposeObject(_propertyBack);
         _propertyBack = null;
         ObjectUtils.disposeObject(_propertyAddImg);
         _propertyAddImg = null;
         ObjectUtils.disposeObject(_rightStarBar);
         _rightStarBar = null;
         ObjectUtils.disposeObject(_starGradeImg);
         _starGradeImg = null;
         ObjectUtils.disposeObject(_bodyBox);
         _bodyBox = null;
         ObjectUtils.disposeObject(_leftStarBar);
         _leftStarBar = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_separateLine);
         _separateLine = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_leftBox);
         _leftBox = null;
         ObjectUtils.disposeObject(_rightBox);
         _rightBox = null;
         ObjectUtils.disposeObject(_promotCountTxt);
         _promotCountTxt = null;
      }
      
      private function addEvent() : void
      {
         MountsManager.instance.avatarList.addEventListener("mountListChange",__mountsUpdateHandler);
         MountsManager.instance.avatarList.addEventListener("mountItemChange",__mountsUpdateHandler);
         _promotBtn.addEventListener("click",__promotHandler);
         _advPromotBtn.addEventListener("click",__advancePromotHandler);
         _returnBtn.addEventListener("click",__returnHandler);
      }
      
      private function removeEvent() : void
      {
         MountsManager.instance.avatarList.removeEventListener("mountListChange",__mountsUpdateHandler);
         MountsManager.instance.avatarList.removeEventListener("mountItemChange",__mountsUpdateHandler);
         if(_promotBtn)
         {
            _promotBtn.removeEventListener("click",__promotHandler);
         }
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",__returnHandler);
         }
         if(_advPromotBtn)
         {
            _advPromotBtn.removeEventListener("click",__advancePromotHandler);
         }
      }
      
      private function __mountsUpdateHandler(param1:Event) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(data.templateId);
         this.data = _loc2_;
      }
      
      private function __promotHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         if(!MountsManager.instance.avatarList.firstBless)
         {
            _loc4_ = int(GoodsManager.instance.getGoodsNumByTempId(208035));
            _loc3_ = 1;
            if(_loc4_ < _loc3_)
            {
               showPromptAlert(_loc3_);
               return;
            }
         }
         if(SharedManager.instance.mountStarNotAlert || Boolean(MountsManager.instance.avatarList.firstBless))
         {
            MountsManager.instance.mountOperateSend(6,data.templateId);
         }
         else
         {
            showPromptFrame();
         }
      }
      
      private function showPromptAlert(param1:int = 1, param2:int = 0) : void
      {
         var _loc6_:int = ConfigInfoManager.instance.getMountStarPoint() * param1;
         SimpleAlertHelper.instance.data = [showPromptAlertBack,_loc6_,param2];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("mountsPromotionView.promotBtn.prompt.Tips01",_loc6_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc7_,_loc3_,_loc4_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            if(param2)
            {
               _loc6_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc6_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc6_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc5_ = param2 ? 2 : 1;
               MountsManager.instance.mountOperateSend(6,data.templateId,_loc5_,param4);
            }
         }
      }
      
      private function showPromptFrame() : void
      {
         var _loc5_:String = null;
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208035);
         if(_loc4_)
         {
            _loc5_ = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc4_.Profile),_loc4_.TemplateName);
         }
         else
         {
            _loc5_ = "";
         }
         var _loc8_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
         var _loc7_:String = LanguageMgr.GetTranslation("mountsPromotionView.promotBtn.prompt",_loc5_,1);
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc8_.show(_loc7_,_loc3_,showPromptFrameBack,null,"center",2,true);
      }
      
      private function showPromptFrameBack(param1:Boolean) : void
      {
         if(isDie)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         if(param1)
         {
            SharedManager.instance.mountStarNotAlert = true;
         }
         MountsManager.instance.mountOperateSend(6,data.templateId);
      }
      
      private function __advancePromotHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208035));
         if(_loc3_ < 10)
         {
            showPromptAlert(10 - _loc3_,1);
            return;
         }
         if(SharedManager.instance.mountStarNotAlertAdv)
         {
            MountsManager.instance.mountOperateSend(6,data.templateId,0,1);
         }
         else
         {
            showAdvancePromptFrame();
         }
      }
      
      private function showAdvancePromptFrame() : void
      {
         var _loc5_:String = null;
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208035);
         if(_loc4_)
         {
            _loc5_ = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc4_.Profile),_loc4_.TemplateName);
         }
         else
         {
            _loc5_ = "";
         }
         var _loc8_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
         var _loc7_:String = LanguageMgr.GetTranslation("mountsPromotionView.promotBtn.prompt",_loc5_,10);
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc8_.show(_loc7_,_loc3_,showAdvancePromptFrameBack,null,"center",2,true);
      }
      
      private function showAdvancePromptFrameBack(param1:Boolean) : void
      {
         if(isDie)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         if(param1)
         {
            SharedManager.instance.mountStarNotAlertAdv = true;
         }
         MountsManager.instance.mountOperateSend(6,data.templateId,0,1);
      }
      
      private function __returnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function get data() : WildSoulInfo
      {
         return _data;
      }
      
      public function set data(param1:WildSoulInfo) : void
      {
         var _loc4_:MountsPromotionItemView = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         _successTxt.visible = false;
         _successImg.visible = false;
         if(!param1)
         {
            _nameTxt.text = "";
            _leftStarBar.visible = false;
            _leftStarBar.progress = 0;
            _rightStarBar.progress = 0;
            _blessBar.gotoAndStop(1);
            _blessTxt.text = "";
            _successTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _bodyBox.data = null;
            _loc6_ = 0;
            while(_loc6_ < _vBox.numChildren)
            {
               _loc4_ = _vBox.getChildAt(_loc6_) as MountsPromotionItemView;
               _loc4_.update(0,0,0);
               _loc6_++;
            }
            _lastStar = 0;
            _data = null;
            return;
         }
         var _loc5_:MountTemplate = param1.template;
         _bodyBox.data = _loc5_;
         _nameTxt.text = _loc5_.TemplateName;
         _leftStarBar.progress = param1.star;
         _rightStarBar.progress = param1.star;
         _leftStarBar.count = _rightStarBar.count = _loc5_.maxStarGrade;
         if(param1.star < _loc5_.maxStarGrade)
         {
            _blessTxt.text = LanguageMgr.GetTranslation("public.slash",param1.bless,param1.blessUpgradeInfo.Data);
            _blessBar.gotoAndStop(int(param1.bless * 100 / param1.blessUpgradeInfo.Data));
            _loc8_ = int(MountsManager.instance.getPromotSuccessRate(param1));
            if(_loc8_ == 100)
            {
               _successTxt.text = StringHelper.format("{0}%",MountsManager.instance.getPromotSuccessRate(param1));
               _successTxt.visible = true;
               _successImg.visible = true;
            }
            _promotBtn.enable = true;
            if(MountsManager.instance.avatarList.firstBless)
            {
               _advPromotBtn.enable = false;
            }
            else
            {
               _advPromotBtn.enable = true;
            }
            _maxGradeImg.visible = false;
            _loc6_ = 0;
            while(_loc6_ < _vBox.numChildren)
            {
               _loc4_ = _vBox.getChildAt(_loc6_) as MountsPromotionItemView;
               _loc2_ = int(param1.star <= 0 ? 0 : _loc5_.starAddList[param1.star - 1]);
               _loc7_ = int(_loc5_.starAddList[param1.star]);
               _loc3_ = _loc7_ - _loc2_;
               switch(_loc6_)
               {
                  case 0:
                     _loc4_.update(_loc5_.Power + _loc2_,_loc5_.Power + _loc7_,_loc3_);
                     break;
                  case 1:
                     _loc4_.update(_loc5_.Intellect + _loc2_,_loc5_.Intellect + _loc7_,_loc3_);
                     break;
                  case 2:
                     _loc4_.update(_loc5_.Physique + _loc2_,_loc5_.Physique + _loc7_,_loc3_);
                     break;
                  case 3:
                     _loc4_.update(_loc5_.Agility + _loc2_,_loc5_.Agility + _loc7_,_loc3_);
               }
               _loc6_++;
            }
         }
         else
         {
            _blessTxt.text = "MAX";
            _blessBar.gotoAndStop(100);
            _successTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _promotBtn.enable = false;
            _advPromotBtn.enable = false;
            _maxGradeImg.visible = true;
            _loc6_ = 0;
            while(_loc6_ < _vBox.numChildren)
            {
               _loc4_ = _vBox.getChildAt(_loc6_) as MountsPromotionItemView;
               _loc2_ = int(param1.star <= 0 ? 0 : _loc5_.starAddList[param1.star - 1]);
               _loc7_ = _loc2_;
               _loc3_ = _loc7_ - _loc2_;
               switch(_loc6_)
               {
                  case 0:
                     _loc4_.update(_loc5_.Power + _loc2_,_loc5_.Power + _loc7_,_loc3_,true);
                     break;
                  case 1:
                     _loc4_.update(_loc5_.Intellect + _loc2_,_loc5_.Intellect + _loc7_,_loc3_,true);
                     break;
                  case 2:
                     _loc4_.update(_loc5_.Physique + _loc2_,_loc5_.Physique + _loc7_,_loc3_,true);
                     break;
                  case 3:
                     _loc4_.update(_loc5_.Agility + _loc2_,_loc5_.Agility + _loc7_,_loc3_,true);
               }
               _loc6_++;
            }
         }
         if(_data && param1.templateId == _data.templateId && param1.star > _lastStar)
         {
            playerUpstarMovie();
         }
         _lastStar = param1.star;
         _data = param1;
         _promotCount = GoodsManager.instance.goodsCountByTempId[208035];
         _promotCountTxt.text = "x " + _promotCount.toString();
      }
      
      public function playerUpstarMovie() : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("mounts.levelupeffect");
         _loc2_.x = _bodyBox.x;
         _loc2_.y = _bodyBox.y + 50;
         var _loc1_:SimpleMovie = new SimpleMovie(_loc2_);
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _leftBox.addChild(_loc1_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

