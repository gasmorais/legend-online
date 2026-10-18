package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.Silder;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CasernRecruitFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _headBg:Bitmap;
      
      private var _expandingImg:Bitmap;
      
      private var _inputBgImg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _recruitPawnTitleText:FilterFrameText;
      
      private var _recruitRequiredTitle:FilterFrameText;
      
      private var _requiredGold:FilterFrameText;
      
      private var _goldIcon:ScaleBitmapImage;
      
      private var _requiredAmount:FilterFrameText;
      
      private var _requiredNum:FilterFrameText;
      
      private var _okBtn:SelectedCheckButton;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _hSilder:Silder;
      
      private var _pawn:ArmyPawn;
      
      private var _model:PlayerModel;
      
      private var _maxNumber:uint;
      
      private var _recruitNum:uint;
      
      private var _noviceRecruitNum:uint;
      
      private var _goldLimit:Number;
      
      private var _pawnTemp:PawnTemplate;
      
      public function CasernRecruitFrame()
      {
         super();
         iniView();
         addEvent();
      }
      
      private function iniView() : void
      {
         titleText = LanguageMgr.GetTranslation("buildings.casern.view.CasernRecruitFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.RecruitBack");
         _expandingImg = ComponentFactory.Instance.creatBitmap("asset.core.expandingImg");
         _headBg = ComponentFactory.Instance.creatBitmap("asset.core.headFrameImg");
         _inputBgImg = ComponentFactory.Instance.creatBitmap("asset.core.RecruitInputBack");
         addToContent(_back);
         addToContent(_expandingImg);
         addToContent(_headBg);
         addToContent(_inputBgImg);
         _recruitRequiredTitle = ComponentFactory.Instance.creatComponentByStylename("core.RecruitRequiredTitle");
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("core.RectruitGoldIcon");
         _requiredGold = ComponentFactory.Instance.creatComponentByStylename("core.RectuitGoldTxt");
         _hSilder = ComponentFactory.Instance.creatComponentByStylename("core.RecruitHSilder");
         _requiredAmount = ComponentFactory.Instance.creatComponentByStylename("core.RequiredAmount");
         _requiredNum = ComponentFactory.Instance.creatComponentByStylename("core.RequiredNum");
         addToContent(_recruitRequiredTitle);
         addToContent(_requiredGold);
         addToContent(_goldIcon);
         _goldIcon.setFrame(1);
         addToContent(_hSilder);
         addToContent(_requiredAmount);
         addToContent(_requiredNum);
         _recruitRequiredTitle.text = LanguageMgr.GetTranslation("buildings.casern.view.CasernRecruitFrame.recruitRequiredTitle");
         _requiredAmount.text = LanguageMgr.GetTranslation("buildings.casern.view.CasernRecruitFrame.requiredAmount");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.RectuitOkBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.RectuitCancelBtn");
         _okBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addToContent(_okBtn);
         addToContent(_cancelBtn);
         _icon = ComponentFactory.Instance.creatCustomObject("core.PawnIcon");
         _recruitPawnTitleText = ComponentFactory.Instance.creatComponentByStylename("core.RecruitPawnTitle");
         _recruitPawnTitleText.text = LanguageMgr.GetTranslation("buildings.casern.view.CasernRecruitFrame.recruitPawnTitle");
         addToContent(_icon);
         addToContent(_recruitPawnTitleText);
         _model = PlayerManager.instance.currentPlayerModel;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_headBg);
         _headBg = null;
         ObjectUtils.disposeObject(_expandingImg);
         _expandingImg = null;
         ObjectUtils.disposeObject(_inputBgImg);
         _inputBgImg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_recruitPawnTitleText);
         _recruitPawnTitleText = null;
         ObjectUtils.disposeObject(_recruitRequiredTitle);
         _recruitRequiredTitle = null;
         ObjectUtils.disposeObject(_requiredGold);
         _requiredGold = null;
         ObjectUtils.disposeObject(_goldIcon);
         _goldIcon = null;
         ObjectUtils.disposeObject(_requiredAmount);
         _requiredAmount = null;
         ObjectUtils.disposeObject(_requiredNum);
         _requiredNum = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_hSilder);
         _hSilder = null;
         ObjectUtils.disposeAllChildren(this);
         _pawn = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _okBtn.addEventListener("click",__onOKHandler);
         _cancelBtn.addEventListener("click",__onCancelHandler);
         _requiredNum.addEventListener("change",__onRequiredNumChangeHandler);
         _requiredNum.addEventListener("keyDown",__keyDownHandler);
         _hSilder.addEventListener("stateChange",__onChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _okBtn.removeEventListener("click",__onOKHandler);
         _cancelBtn.removeEventListener("click",__onCancelHandler);
         _requiredNum.removeEventListener("change",__onRequiredNumChangeHandler);
         _requiredNum.removeEventListener("keyDown",__keyDownHandler);
         _hSilder.removeEventListener("stateChange",__onChangeHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            case 2:
               __onOKHandler(null);
         }
      }
      
      protected function __onOKHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.sendRecruitPawn(_pawn.templateId,_recruitNum);
         _noviceRecruitNum = _recruitNum;
         dispose();
      }
      
      protected function __onCancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function get population() : ResourceData
      {
         return ResourceManager.instance.population;
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         _recruitNum = Math.round(_hSilder.value);
         _hSilder.getThumb().tipData = _recruitNum;
         refreshResource();
      }
      
      private function __onRequiredNumChangeHandler(param1:Event) : void
      {
         if(int(_requiredNum.text) <= 0)
         {
            _requiredNum.text = "1";
         }
         else if(int(_requiredNum.text) >= _maxNumber)
         {
            _requiredNum.text = String(_maxNumber);
         }
         _requiredNum.text = int(_requiredNum.text).toString();
         _hSilder.value = int(_requiredNum.text);
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onOKHandler(null);
         }
         param1.stopPropagation();
      }
      
      public function get data() : ArmyPawn
      {
         return _pawn;
      }
      
      public function set data(param1:ArmyPawn) : void
      {
         _pawn = param1;
         _icon.icon = IconFactory.getSoldierIconByIcon(param1.templateInfo.Icon);
         _icon.tipData = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_pawn != null)
         {
            _loc2_ = _pawn.templateInfo.NeedPopulation;
            _loc1_ = (population.limit - population.count) / _loc2_;
            _goldLimit = getPopulationByGolds(_pawn,gold.count);
            _maxNumber = Math.min(_loc1_,_goldLimit);
            _recruitNum = _maxNumber;
            _hSilder.maximum = Math.min(_loc1_,_goldLimit);
            _hSilder.minimum = _maxNumber >= 1 ? 1 : 0;
            _hSilder.value = _maxNumber;
            _recruitPawnTitleText.text = _pawn.templateInfo.PawnName;
            refreshResource();
         }
      }
      
      private function getPopulationByGolds(param1:ArmyPawn, param2:int) : int
      {
         var _loc4_:PawnTemplate = _pawn.templateInfo;
         var _loc6_:BuildingTempInfo = BuildingManager.instance.getMaxEffectBuildingTemplate(_loc4_).sortOn("Property4",0x10 | 2)[0];
         var _loc3_:Number = _loc6_.Property4 / 100;
         var _loc5_:Number = _model.playerEffect.getRecruitPawnResourceAddition(_loc4_.GoldConsume * (1 - _loc3_));
         return int(param2 / _loc5_);
      }
      
      private function refreshResource() : void
      {
         if(_recruitNum > _goldLimit)
         {
            _recruitNum = _goldLimit;
         }
         _requiredNum.text = _recruitNum.toString();
         _pawnTemp = _pawn.templateInfo;
         _requiredGold.text = recruitGold.toString();
         _goldIcon.x = _requiredGold.x + _requiredGold.textWidth + 5;
      }
      
      private function get recruitGold() : uint
      {
         var _loc2_:BuildingTempInfo = BuildingManager.instance.getMaxEffectBuildingTemplate(_pawnTemp).sortOn("Property4",0x10 | 2)[0];
         var _loc1_:Number = _model.playerEffect.getRecruitPawnResourceAddition(_pawnTemp.GoldConsume * (1 - _loc2_.Property4 / 100));
         return Math.ceil(_recruitNum * _loc1_);
      }
      
      private function get recruitPopulation() : uint
      {
         return _pawnTemp.NeedPopulation * _recruitNum;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

