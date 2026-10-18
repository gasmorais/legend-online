package childarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.VIPManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildArenaRewardTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildArenaSignFrame extends Frame
   {
      
      private var back:Bitmap;
      
      private var joinBtn1:IconButton;
      
      private var joinBtn2:IconButton;
      
      private var signText1:FilterFrameText;
      
      private var signText2:FilterFrameText;
      
      private var warText1:FilterFrameText;
      
      private var warText2:FilterFrameText;
      
      private var rewardHbox1:HBox;
      
      private var rewardHbox2:HBox;
      
      private var enterBtn:IconButton;
      
      private var autoJoinImage1:Bitmap;
      
      private var autoJoinImage2:Bitmap;
      
      private var autoHelpImage1:Image;
      
      private var autoHelpImage2:Image;
      
      private var autoJoinBtn1:SelectedButton;
      
      private var autoJoinBtn2:SelectedButton;
      
      private var autoSignVipGrade:int;
      
      public function ChildArenaSignFrame()
      {
         super();
         initView();
         initRewardView();
         addEvent();
         ChildSender.requestChildArenaOp(0);
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:String = null;
         back = ComponentFactory.Instance.creatBitmap("asset.ChildArenaSignFrame.back");
         joinBtn1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.joinBtn1");
         joinBtn2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.joinBtn2");
         signText1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.signText1");
         signText2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.signText2");
         warText1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.warText1");
         warText2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.warText2");
         rewardHbox1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.rewardHbox1");
         rewardHbox2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.rewardHbox2");
         enterBtn = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.enterBtn");
         autoJoinImage1 = ComponentFactory.Instance.creatBitmap("asset.ChildArenaSignFrame.autoJoinImage");
         autoJoinImage2 = ComponentFactory.Instance.creatBitmap("asset.ChildArenaSignFrame.autoJoinImage");
         autoHelpImage1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.autoHelpImage1");
         autoHelpImage2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.autoHelpImage2");
         autoJoinBtn1 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.autoJoinBtn1");
         autoJoinBtn2 = ComponentFactory.Instance.creatComponentByStylename("ChildArenaSignFrame.autoJoinBtn2");
         addToContent(back);
         addToContent(joinBtn1);
         addToContent(joinBtn2);
         addToContent(signText1);
         addToContent(signText2);
         addToContent(warText1);
         addToContent(warText2);
         addToContent(autoJoinImage1);
         addToContent(autoJoinImage2);
         autoJoinImage2.y = 350;
         addToContent(autoHelpImage1);
         addToContent(autoHelpImage2);
         addToContent(autoJoinBtn1);
         addToContent(autoJoinBtn2);
         addToContent(rewardHbox1);
         addToContent(rewardHbox2);
         addToContent(enterBtn);
         signText1.text = LanguageMgr.GetTranslation("ChildArenaSignFrame.signText1.text",arenaModel.childPvpTimeArr[0],arenaModel.childPvpTimeArr[1]);
         signText2.text = LanguageMgr.GetTranslation("ChildArenaSignFrame.signText1.text",arenaModel.childPvpTimeArr[0],arenaModel.childPvpTimeArr[1]);
         warText1.text = LanguageMgr.GetTranslation("ChildArenaSignFrame.warText1.text",arenaModel.childPvpTimeArr[3],arenaModel.childPvpTimeArr[4]);
         warText2.text = LanguageMgr.GetTranslation("ChildArenaSignFrame.warText1.text",arenaModel.childPvpTimeArr[3],arenaModel.childPvpTimeArr[4]);
         autoSignVipGrade = ConfigInfoManager.instance.getChildArenaAutoSignVipGrade();
         if(isVipAndGradeNeeded)
         {
            _loc1_ = "<font color=\'#00C913\'>" + LanguageMgr.GetTranslation("ChildArenaSignFrame.autoHelpImage.signVipGrade",autoSignVipGrade) + "</font>";
         }
         else
         {
            _loc1_ = "<font color=\'#CE0F0F\'>" + LanguageMgr.GetTranslation("ChildArenaSignFrame.autoHelpImage.signVipGrade",autoSignVipGrade) + "</font>";
         }
         autoHelpImage1.tipData = autoHelpImage2.tipData = _loc1_ + LanguageMgr.GetTranslation("ChildArenaSignFrame.autoHelpImage.tipdata");
      }
      
      private function initRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc2_:ChildArenaRewardTemplateInfo = null;
         var _loc5_:Array = TempleteManager.instance.childArenaRewardTempCate.getTemplatesByTypeAndRank(1,4);
         var _loc3_:Array = TempleteManager.instance.childArenaRewardTempCate.getTemplatesByTypeAndRank(2,4);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildArenaSignFrame.rewardItem");
            _loc2_ = _loc5_[_loc4_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc2_.itemId;
            _loc6_.count = _loc2_.count;
            _loc1_.data = _loc6_;
            rewardHbox1.addChild(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildArenaSignFrame.rewardItem");
            _loc2_ = _loc3_[_loc4_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc2_.itemId;
            _loc6_.count = _loc2_.count;
            _loc1_.data = _loc6_;
            rewardHbox2.addChild(_loc1_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         joinBtn1.addEventListener("click",__joinBtnClickHandler);
         joinBtn2.addEventListener("click",__joinBtnClickHandler);
         enterBtn.addEventListener("click",__enterBtnClickHandler);
         autoJoinBtn1.addEventListener("click",__autoSignClickHandler);
         autoJoinBtn2.addEventListener("click",__autoSignClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__updateChildArenaStateHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(joinBtn1)
         {
            joinBtn1.removeEventListener("click",__joinBtnClickHandler);
         }
         if(joinBtn2)
         {
            joinBtn2.removeEventListener("click",__joinBtnClickHandler);
         }
         if(enterBtn)
         {
            enterBtn.removeEventListener("click",__enterBtnClickHandler);
         }
         if(autoJoinBtn1)
         {
            autoJoinBtn1.removeEventListener("click",__autoSignClickHandler);
         }
         if(autoJoinBtn2)
         {
            autoJoinBtn2.removeEventListener("click",__autoSignClickHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__updateChildArenaStateHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
      }
      
      private function __autoSignClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(!isVipAndGradeNeeded)
         {
            refreshAutoState();
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.autoJoin.needVipAndGrae",autoSignVipGrade));
            return;
         }
         if(param1.currentTarget is SelectedButton && param1.currentTarget.stylename == "ChildArenaSignFrame.autoJoinBtn1")
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget is SelectedButton && param1.currentTarget.stylename == "ChildArenaSignFrame.autoJoinBtn2")
         {
            _loc4_ = 2;
         }
         if(arenaModel.autoSignState == _loc4_)
         {
            cancelAlert();
         }
         else
         {
            SimpleAlertHelper.instance.data = [__autoSignResultHandler,_loc4_];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.autoSelectContent");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true);
         }
      }
      
      private function cancelAlert() : void
      {
         SimpleAlertHelper.instance.data = [__autoSignResultHandler,0];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.autoCancelContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true);
      }
      
      private function __autoSignResultHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            ChildSender.requestChildArenaOp(9,param3);
         }
      }
      
      private function __childArenaIsgroupingHandler(param1:String, param2:Object) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpvp.state.isgroupingAlert"));
         dispose();
      }
      
      private function __updateChildArenaStateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = "";
         var _loc5_:int = 0;
         if(!arenaModel.canSignUp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.timeAlert",arenaModel.childPvpTimeArr[0],arenaModel.childPvpTimeArr[1]));
            return;
         }
         if(arenaModel.curstate != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.timeAlert",arenaModel.childPvpTimeArr[0],arenaModel.childPvpTimeArr[1]));
            return;
         }
         if(param1.currentTarget is IconButton && param1.currentTarget.stylename == "ChildArenaSignFrame.joinBtn1")
         {
            _loc5_ = 1;
            _loc4_ = LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.arenaType1");
            if(!ArmyManager.instance.thane.isChangeJob)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.gradeAlert",_loc4_));
               return;
            }
         }
         else if(param1.currentTarget is IconButton && param1.currentTarget.stylename == "ChildArenaSignFrame.joinBtn2")
         {
            _loc5_ = 2;
            _loc4_ = LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.arenaType2");
         }
         SimpleAlertHelper.instance.data = [__alertResponseHandler,_loc5_];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("ChildArenaSignFrame.signUp.arenaTypeContent",_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,true);
      }
      
      private function __alertResponseHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            ChildSender.requestChildArenaOp(2,param3);
         }
      }
      
      private function __enterBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childarena","MAIN_FRAME");
      }
      
      private function refreshView() : void
      {
         if(arenaModel.isSign)
         {
            if(arenaModel.arenaType == 1)
            {
               joinBtn1.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text2";
               joinBtn1.iconInnerRectString = "27,78,7,30,13";
               joinBtn2.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text1";
               joinBtn2.iconInnerRectString = "37,65,7,30,13";
            }
            else
            {
               joinBtn2.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text2";
               joinBtn2.iconInnerRectString = "27,78,7,30,13";
               joinBtn1.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text1";
               joinBtn1.iconInnerRectString = "37,65,7,30,13";
            }
            joinBtn1.enable = joinBtn2.enable = false;
         }
         else
         {
            joinBtn1.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text1";
            joinBtn1.iconInnerRectString = "37,65,7,30,13";
            joinBtn2.iconStyle = "asset.ChildArenaSignFrame.joinBtn1Text1";
            joinBtn2.iconInnerRectString = "37,65,7,30,13";
         }
         refreshAutoState();
      }
      
      private function refreshAutoState() : void
      {
         if(arenaModel.autoSignState == 1)
         {
            autoJoinBtn1.selected = true;
            autoJoinBtn2.selected = false;
         }
         else if(arenaModel.autoSignState == 2)
         {
            autoJoinBtn1.selected = false;
            autoJoinBtn2.selected = true;
         }
         else
         {
            autoJoinBtn1.selected = false;
            autoJoinBtn2.selected = false;
         }
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ChildArenaSignFrame.titleText.text");
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      private function get isVipAndGradeNeeded() : Boolean
      {
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < autoSignVipGrade)
         {
            return false;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(joinBtn1);
         joinBtn1 = null;
         ObjectUtils.disposeObject(joinBtn2);
         joinBtn2 = null;
         ObjectUtils.disposeObject(signText1);
         signText1 = null;
         ObjectUtils.disposeObject(signText2);
         signText2 = null;
         ObjectUtils.disposeObject(warText1);
         warText1 = null;
         ObjectUtils.disposeObject(warText2);
         warText2 = null;
         ObjectUtils.disposeObject(rewardHbox1);
         rewardHbox1 = null;
         ObjectUtils.disposeObject(rewardHbox2);
         rewardHbox2 = null;
         ObjectUtils.disposeObject(enterBtn);
         enterBtn = null;
         ObjectUtils.disposeObject(autoJoinBtn1);
         autoJoinBtn1 = null;
         ObjectUtils.disposeObject(autoJoinBtn2);
         autoJoinBtn2 = null;
         ObjectUtils.disposeObject(autoHelpImage1);
         autoHelpImage1 = null;
         ObjectUtils.disposeObject(autoHelpImage2);
         autoHelpImage2 = null;
         ObjectUtils.disposeObject(autoJoinImage1);
         autoJoinImage1 = null;
         ObjectUtils.disposeObject(autoJoinImage2);
         autoJoinImage2 = null;
         super.dispose();
      }
   }
}

