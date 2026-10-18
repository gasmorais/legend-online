package armyII.viewII.allocate
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.PawnContain;
   
   public class AllocateView extends Sprite implements Disposeable
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _back3:MutipleImage;
      
      private var _back4:SimpleTileList;
      
      private var _back5:Bitmap;
      
      private var _back4Count:int = 6;
      
      private var _countBack:Bitmap;
      
      private var _count:Bitmap;
      
      private var _storeTxt:Bitmap;
      
      private var _storeBg:Image;
      
      private var _pawn:SoldierDragCell;
      
      private var _frontRowBtn:IconButton;
      
      private var _backRowBtn:IconButton;
      
      private var _autoBtn:BaseButton;
      
      private var _recruitBtn:IconButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _containerList:Vector.<PawnDragCell>;
      
      private var _scrollContain:Sprite;
      
      private var _pawnContain:Sprite;
      
      private var _shape:Shape;
      
      private var _numberBitmapData:BitmapData;
      
      private var _numHBox:HBox;
      
      private var _numHBox1:Sprite;
      
      private var _splice:Bitmap;
      
      private var _numHBox2:Sprite;
      
      private var _totalLen:int;
      
      private var _frontRowIndex:int = 1;
      
      private var _backRowIndex:int = 3;
      
      public function AllocateView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:* = 0;
         _back1 = ComponentFactory.Instance.creatComponentByStylename("army.AllocateFrameBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("army.AllocateFrameBack2");
         _autoBtn = ComponentFactory.Instance.creatComponentByStylename("army.AllocateAutoBtn");
         _recruitBtn = ComponentFactory.Instance.creatComponentByStylename("army.AllocateRecruitBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("army.AllocateScrollPanel");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("army.Allocate3");
         _back4 = ComponentFactory.Instance.creatCustomObject("army.Allocate.SimpleTileList",[_back4Count]);
         _back5 = ComponentFactory.Instance.creatBitmap("asset.army.RightBg");
         _countBack = ComponentFactory.Instance.creatBitmap("asset.army.CountTxtBack");
         _count = ComponentFactory.Instance.creatBitmap("asset.army.CountTxt");
         _storeTxt = ComponentFactory.Instance.creatBitmap("asset.army.PawnTxtAsset");
         _storeBg = ComponentFactory.Instance.creatComponentByStylename("army.AllocateTextBg");
         _pawn = ComponentFactory.Instance.creatCustomObject("army.SoldierDragCell1");
         _frontRowBtn = ComponentFactory.Instance.creatComponentByStylename("army.AllocateFrontRowBtn");
         _backRowBtn = ComponentFactory.Instance.creatComponentByStylename("army.AllocateBackRowBtn");
         _pawnContain = ComponentFactory.Instance.creatCustomObject("army.AllocatePawnView");
         _back4.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _back4Count)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.army.Allocate4");
            _back4.addChild(_loc1_);
            _loc2_++;
         }
         _back4.commitChanges();
         _back4.scrollRect = new Rectangle(0,0,279,48);
         _scrollContain = new Sprite();
         _frontRowBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.allocate.frontRowBtn.TipTxt");
         _backRowBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.allocate.backRowBtn.TipTxt");
         addChild(_back1);
         addChild(_back2);
         addChild(_back3);
         addChild(_back4);
         addChild(_back5);
         addChild(_countBack);
         addChild(_count);
         addChild(_pawn);
         addChild(_frontRowBtn);
         addChild(_backRowBtn);
         addChild(_recruitBtn);
         addChild(_autoBtn);
         addChild(_scrollPanel);
         addChild(_storeBg);
         addChild(_storeTxt);
         _scrollPanel.setView(_scrollContain);
         _numberBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_06").clone();
         _numHBox = ComponentFactory.Instance.creatComponentByStylename("army.combatPowerContain");
         _numHBox1 = new Sprite();
         _splice = ComponentFactory.Instance.creatBitmap("asset.army.NumberSpliceAsset");
         _numHBox2 = new Sprite();
         _numHBox.addChild(_numHBox1);
         _numHBox.addChild(_splice);
         _numHBox.addChild(_numHBox2);
         addChild(_numHBox);
         _shape = createShape();
         _scrollContain.addChild(_shape);
         _scrollContain.addChild(_pawnContain);
         _containerList = new Vector.<PawnDragCell>();
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,235,150);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      protected function addEvent() : void
      {
         _recruitBtn.addEventListener("click",__recruitHandler);
         _autoBtn.addEventListener("click",__autoAllocateHandler);
         _frontRowBtn.addEventListener("click",__frontRowBtnClickHandler);
         _backRowBtn.addEventListener("click",__backRowBtnClickHandler);
         userArmy.addEventListener("ARMY_PAWN_CHANGE",__countChangeHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
      }
      
      protected function removeEvent() : void
      {
         _recruitBtn.removeEventListener("click",__recruitHandler);
         _autoBtn.removeEventListener("click",__autoAllocateHandler);
         _frontRowBtn.removeEventListener("click",__frontRowBtnClickHandler);
         _backRowBtn.removeEventListener("click",__backRowBtnClickHandler);
         userArmy.removeEventListener("ARMY_PAWN_CHANGE",__countChangeHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
      }
      
      private function __countChangeHandler(param1:ArmyEvent) : void
      {
         refreshView();
      }
      
      private function __pawnChangeHandler(param1:ArmyEvent) : void
      {
         refreshView();
      }
      
      private function __recruitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.startFrameByType(ArmyPanelEnum.RECRUIT_PAWN);
      }
      
      private function __autoAllocateHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.autoAllocate();
      }
      
      private function __frontRowBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         thane.fightPos = _backRowIndex;
         armyPawn.fightPos = _frontRowIndex;
         ArmySocketOutManager.sendEditArmyPos(thane.userId,thane.fightPos,armyPawn.fightPos);
         refreshRowBtnState();
         ArmyManager.instance.isSorted = true;
      }
      
      private function __backRowBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         thane.fightPos = _frontRowIndex;
         armyPawn.fightPos = _backRowIndex;
         ArmySocketOutManager.sendEditArmyPos(thane.userId,thane.fightPos,armyPawn.fightPos);
         refreshRowBtnState();
         ArmyManager.instance.isSorted = true;
      }
      
      private function refreshRowBtnState() : void
      {
         _frontRowBtn.enable = false;
         _backRowBtn.enable = false;
         if(_pawn.pawn.ownPawns != 0)
         {
            if(thane.fightPos == _frontRowIndex && armyPawn.fightPos == _backRowIndex)
            {
               _frontRowBtn.enable = true;
            }
            else if(thane.fightPos == _backRowIndex && armyPawn.fightPos == _frontRowIndex)
            {
               _backRowBtn.enable = true;
            }
            else
            {
               _backRowBtn.enable = true;
            }
         }
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:PawnDragCell = null;
         var _loc3_:int = 0;
         while(_pawnContain.numChildren > 0)
         {
            _pawnContain.removeChildAt(0);
         }
         var _loc5_:ArmyPawn = userArmy.getPawnByIndex(0);
         _pawn.pawn = _loc5_;
         refreshCount();
         var _loc4_:Array = ArmyManager.instance.castlePawnList.getList();
         _loc4_ = filterByCount(_loc4_);
         _loc4_.sort(sortByNeedBuild);
         var _loc2_:int = int(_loc4_.length);
         var _loc6_:int = int(_loc4_.length);
         _loc2_ = _loc2_ < 6 ? 6 : 3 * (int((_loc2_ + 2) / 3));
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("army.PawnDragCell");
            if(_loc3_ < _loc6_)
            {
               _loc1_.pawn = _loc4_[_loc3_] as ArmyPawn;
            }
            else
            {
               _loc1_.pawn = null;
            }
            _loc1_.x = int(_loc3_ % 3) * (_loc1_.displayWidth + 4);
            _loc1_.y = int(_loc3_ / 3) * (_loc1_.displayHeight + 0);
            _pawnContain.addChild(_loc1_);
            _containerList.push(_loc1_);
            _loc3_++;
         }
         _shape.height = _pawnContain.x + _pawnContain.height;
         _scrollPanel.invalidateViewport();
         refreshRowBtnState();
      }
      
      private function sortByNeedBuild(param1:ArmyPawn, param2:ArmyPawn) : int
      {
         var _loc4_:int = int(param1.templateInfo.NeedBuilding);
         var _loc3_:int = int(param2.templateInfo.NeedBuilding);
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         return 0;
      }
      
      private function filterByCount(param1:Array) : Array
      {
         var _loc6_:ArmyPawn = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc3_:ArmyPawn = userArmy.getPawnByIndex(0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_] as ArmyPawn;
            if(_loc6_.ownPawns > 0 || _loc6_.templateId == _loc3_.templateId && _loc3_.ownPawns > 0)
            {
               _loc2_.push(param1[_loc5_]);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function refreshCount() : void
      {
         NumberViewUtils.refreshValue(userArmy.countAllArmyPawnNmber(),_numHBox1,_numberBitmapData,17,15,12,17,"0123456789");
         NumberViewUtils.refreshValue(userArmy.baseHero.attackProrerty.totalConatArmy,_numHBox2,_numberBitmapData,17,15,12,17,"0123456789");
         _numHBox.refreshChildPos();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return userArmy.baseHero;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get armyPawn() : ArmyPawn
      {
         return ArmyManager.instance.army.armyPawns[0];
      }
      
      public function get autoBtn() : BaseButton
      {
         return _autoBtn;
      }
      
      public function get SoldierPawn() : SoldierDragCell
      {
         return _pawn;
      }
      
      public function getPawnDragCellByMasterType(param1:int) : PawnDragCell
      {
         for each(var _loc2_:PawnDragCell in _containerList)
         {
            if(_loc2_.pawn)
            {
               if(_loc2_.pawn.templateInfo.MasterType == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         DragManager.getInstance().stopDrag();
         for each(var _loc1_:PawnContain in _containerList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_back4);
         _back4 = null;
         ObjectUtils.disposeObject(_back5);
         _back5 = null;
         ObjectUtils.disposeObject(_countBack);
         _countBack = null;
         ObjectUtils.disposeObject(_count);
         _count = null;
         ObjectUtils.disposeObject(_storeTxt);
         _storeTxt = null;
         ObjectUtils.disposeObject(_storeBg);
         _storeBg = null;
         ObjectUtils.disposeObject(_pawn);
         _pawn = null;
         ObjectUtils.disposeObject(_frontRowBtn);
         _frontRowBtn = null;
         ObjectUtils.disposeObject(_backRowBtn);
         _backRowBtn = null;
         ObjectUtils.disposeObject(_autoBtn);
         _autoBtn = null;
         ObjectUtils.disposeObject(_recruitBtn);
         _recruitBtn = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_scrollContain);
         _scrollContain = null;
         ObjectUtils.disposeObject(_pawnContain);
         _pawnContain = null;
         ObjectUtils.disposeObject(_numberBitmapData);
         _numberBitmapData = null;
         ObjectUtils.disposeObject(_numHBox);
         _numHBox = null;
         ObjectUtils.disposeObject(_numHBox1);
         _numHBox1 = null;
         ObjectUtils.disposeObject(_numHBox2);
         _numHBox2 = null;
         ObjectUtils.disposeObject(_splice);
         _splice = null;
         _containerList = null;
         _shape = null;
      }
   }
}

