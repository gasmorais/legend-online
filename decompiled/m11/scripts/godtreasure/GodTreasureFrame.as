package godtreasure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.FunnyManager;
   import map.space.SpaceManager;
   import mvc.controler.GodTreasureControler;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.godTreasure.GodTreasureInfo;
   import mvc.module.godTreasure.GodTreasureModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class GodTreasureFrame extends Frame
   {
      
      private var _controller:GodTreasureControler;
      
      private var bg:MutipleImage;
      
      private var _congratulate:Bitmap;
      
      private var _inputAndoutput:Bitmap;
      
      private var _decorate:Bitmap;
      
      private var _pattern:Bitmap;
      
      private var _diamondbImg1:MutipleImage;
      
      private var _diamondbImg2:MutipleImage;
      
      private var _diamondbImg3:MutipleImage;
      
      private var _times:FilterFrameText;
      
      private var _gotDiamond:FilterFrameText;
      
      private var _inputDiamond:GradientText;
      
      private var _outputDiamond:GradientText;
      
      private var _jionBtn:IconButton;
      
      private var boxMC:MovieClip;
      
      private var _model:GodTreasureModel;
      
      private var _degree:int;
      
      private var _diamond:int;
      
      private var _level:int;
      
      private var _helpBtn:BaseButton;
      
      private var _remainTime:int;
      
      private var _arr:Array = [];
      
      private var refuseInvite:Boolean;
      
      private var refuseTeamInvite:Boolean;
      
      public function GodTreasureFrame()
      {
         super();
         _controller = FrameControllerManager.instance.godTreasureControler;
         _controller.sendOpen();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.title");
         bg = ComponentFactory.Instance.creatComponentByStylename("godTreasure.bg");
         _congratulate = ComponentFactory.Instance.creatBitmap("asset.godTreasure.congratulate");
         _inputAndoutput = ComponentFactory.Instance.creatBitmap("asset.godTreasure.input");
         _diamondbImg1 = ComponentFactory.Instance.creatComponentByStylename("godTreasure.diamond1");
         _diamondbImg2 = ComponentFactory.Instance.creatComponentByStylename("godTreasure.diamond2");
         _diamondbImg3 = ComponentFactory.Instance.creatComponentByStylename("godTreasure.diamond3");
         _times = ComponentFactory.Instance.creatComponentByStylename("godTreasure.times.text");
         _gotDiamond = ComponentFactory.Instance.creatComponentByStylename("godTreasure.gotdiamond.text");
         _inputDiamond = ComponentFactory.Instance.creatComponentByStylename("godTreasure.inputDiamondTxt");
         _outputDiamond = ComponentFactory.Instance.creatComponentByStylename("godTreasure.outputDiamondTxt");
         _jionBtn = ComponentFactory.Instance.creatComponentByStylename("godTreasure.jionBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("godtreasure.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("activity.godtreasure.godtreasureHelpFrame.helpBtnTipData");
         boxMC = ComponentFactory.Instance.creatCustomObject("godTreasure.boxEffect");
         boxMC.gotoAndStop(1);
         addToContent(bg);
         addToContent(_congratulate);
         addToContent(_inputAndoutput);
         addToContent(_times);
         addToContent(_diamondbImg1);
         addToContent(_diamondbImg2);
         addToContent(_diamondbImg3);
         addToContent(_gotDiamond);
         addToContent(_inputDiamond);
         addToContent(_outputDiamond);
         addToContent(_jionBtn);
         addToContent(_helpBtn);
         addToContent(boxMC);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function openFrame(param1:GodTreasureInfo) : void
      {
         refreshView(param1);
      }
      
      private function refreshView(param1:GodTreasureInfo) : void
      {
         _arr = TempleteManager.instance.godTreasureTemplateCate.grades;
         _degree = param1.grade + 1;
         _gotDiamond.text = String(param1.investDiamond);
         _jionBtn.enable = true;
         _congratulate.visible = true;
         _gotDiamond.visible = true;
         _diamondbImg1.visible = true;
         if(_degree == 1)
         {
            _congratulate.visible = false;
            _gotDiamond.visible = false;
            _diamondbImg1.visible = false;
         }
         if(_degree > _arr.length)
         {
            _jionBtn.enable = false;
            _inputDiamond.visible = false;
            _outputDiamond.visible = false;
            _times.text = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.timestext",_arr.length);
         }
         else
         {
            _inputDiamond.text = String(TempleteManager.instance.godTreasureTemplateCate.getItemByGrade(_degree).InvestDiamond);
            _outputDiamond.text = String(TempleteManager.instance.godTreasureTemplateCate.getItemByGrade(_degree).ProfitDisplay);
            _times.text = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.timestext",_degree);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,745,550);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         var _loc1_:* = undefined;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.x = (StageReferance.stageWidth - this.width) / 2;
         try
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(SpaceManager.instance.model.selfArmy as BaseArmy);
            _loc1_.stopWalkByOut();
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateView(param1:GodTreasureInfo) : void
      {
         _degree = param1.grade + 1;
         _gotDiamond.visible = true;
         _congratulate.visible = true;
         _diamondbImg1.visible = true;
         _level = param1.level;
         _diamond = param1.investDiamond;
         boxMC.gotoAndStop(4);
         boxMC["box"].addEventListener("complete",__mcCompleteHandler);
      }
      
      private function __mcCompleteHandler(param1:Event) : void
      {
         boxMC.removeEventListener("complete",__mcCompleteHandler);
         boxMC.gotoAndStop(3);
         boxMC["box1"].addEventListener("complete",__mcGetRewardHandler);
      }
      
      private function __mcGetRewardHandler(param1:Event) : void
      {
         boxMC.removeEventListener("complete",__mcGetRewardHandler);
         if(_level == 1)
         {
            getReward();
         }
         else
         {
            boxMC.gotoAndStop(7);
            boxMC["box2"].addEventListener("complete",__GetReward2Handler);
         }
      }
      
      private function __GetReward2Handler(param1:Event) : void
      {
         boxMC.removeEventListener("complete",__GetReward2Handler);
         getReward();
      }
      
      public function getReward() : void
      {
         _controller.sendGetReward();
         _gotDiamond.text = String(_diamond);
         _jionBtn.enable = true;
         _arr = TempleteManager.instance.godTreasureTemplateCate.grades;
         if(_degree > _arr.length)
         {
            _jionBtn.enable = false;
            _inputDiamond.visible = false;
            _outputDiamond.visible = false;
            _inputAndoutput.visible = false;
            _diamondbImg2.visible = false;
            _diamondbImg3.visible = false;
            _times.text = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.timestext",_arr.length);
         }
         else
         {
            _inputDiamond.text = String(TempleteManager.instance.godTreasureTemplateCate.getItemByGrade(_degree).InvestDiamond);
            _outputDiamond.text = String(TempleteManager.instance.godTreasureTemplateCate.getItemByGrade(_degree).ProfitDisplay);
            _times.text = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.timestext",_degree);
         }
         if(_level == 1)
         {
            boxMC.gotoAndStop(5);
         }
         else
         {
            boxMC.gotoAndStop(6);
         }
         this.closeButton.enable = true;
      }
      
      private function sendRefuseInvite() : void
      {
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
            refuseInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
         }
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
            refuseTeamInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
         }
      }
      
      private function removeRefuseInvite() : void
      {
         if(!refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function addEvent() : void
      {
         if(_jionBtn)
         {
            _jionBtn.addEventListener("click",_jionBtnClick);
         }
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpClick);
         sendRefuseInvite();
      }
      
      private function removeEvent() : void
      {
         if(_jionBtn)
         {
            _jionBtn.removeEventListener("click",_jionBtnClick);
         }
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpClick);
         removeRefuseInvite();
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.godTreasureControler.openGodTreasureHelpFrame();
      }
      
      private function _jionBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:int = 0;
         _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_loc4_ < TempleteManager.instance.godTreasureTemplateCate.getItemByGrade(_degree).InvestDiamond)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.godtreasure.godtreasure.canNotJoin"));
            return;
         }
         var _loc5_:Number = FunnyManager.instance.godTreasureEnd - 180000;
         if(PlayerManager.instance.currentPlayerModel.nowDate >= _loc5_)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.godtreasure.GodTreasureFrame.str");
            SimpleAlertHelper.instance.data = [];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,"",false,true,true);
            return;
         }
         boxMC.gotoAndStop(2);
         this.closeButton.enable = false;
         _jionBtn.enable = false;
         _controller.jionHandler(_degree);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function _animation() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         boxMC.stop();
         ObjectUtils.disposeViolentMc(boxMC);
         boxMC = null;
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_times);
         _times = null;
         ObjectUtils.disposeObject(_gotDiamond);
         _gotDiamond = null;
         ObjectUtils.disposeObject(_inputDiamond);
         _inputDiamond = null;
         ObjectUtils.disposeObject(_outputDiamond);
         _outputDiamond = null;
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
   }
}

