package map.internals.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.data.MapPhysics;
   import map.internals.data.WildLand;
   import map.internals.interfaces.IOuterFrame;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.BaseArmy;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.IconFactory;
   import yishi.view.community.HeroCell;
   import yishi.view.community.PawnContain;
   
   public class TreasureFrameView extends Sprite implements IOuterFrame
   {
      
      private var _frameId:uint;
      
      private var _armyBg:DisplayObject;
      
      protected var _info:MapPhysics;
      
      private var _attackBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _frame:Frame;
      
      private var _baseBackGround:ScaleBitmapImage;
      
      private var _defenseForcesImg:Bitmap;
      
      private var _hBox:HBox;
      
      public function TreasureFrameView()
      {
         super();
         _frameId = 4;
         init();
      }
      
      private function init() : void
      {
         _baseBackGround = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.TreasureContentBg");
         addChild(_baseBackGround);
         _defenseForcesImg = new Bitmap(ComponentFactory.Instance.creatBitmapData("asset.outercity.DefenseForcesImg"));
         _defenseForcesImg.x = -15;
         addChild(_defenseForcesImg);
         _hBox = new HBox();
         _hBox.spacing = 50;
         _hBox.x = 12;
         _hBox.y = 24;
         addChild(_hBox);
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.TreasureAttackBtnAsset");
         var _loc2_:String = LanguageMgr.GetTranslation("public.attack1");
         _attackBtn.text = _loc2_;
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.TreasureCancleBtnAsset");
         var _loc1_:String = LanguageMgr.GetTranslation("public.cancel");
         _cancleBtn.text = _loc1_;
         addChild(_attackBtn);
         addChild(_cancleBtn);
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
      }
      
      protected function __onCancleClick(param1:MouseEvent) : void
      {
      }
      
      public function show(param1:Object) : void
      {
         _info = param1 as MapPhysics;
         showFrame(param1);
         reArmyView(currentArmy);
         addEvent();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      protected function showFrame(param1:Object) : void
      {
         var _loc2_:WildLand = param1 as WildLand;
         if(!_frame)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.TreasureFrame");
         }
         _frame.titleText = _loc2_.tempInfo.MapPhysicsTempName + " Nv." + _loc2_.tempInfo.Grades;
         _frame.addToContent(this);
         LayerManager.Instance.addToLayer(_frame,3,true,true,1);
      }
      
      protected function addEvent() : void
      {
         _frame.addEventListener("response",__frameEvent);
         _attackBtn.addEventListener("click",__onClickHandler);
         _cancleBtn.addEventListener("click",__onCancleClick);
      }
      
      protected function removeEvent() : void
      {
         if(_frame)
         {
            _frame.removeEventListener("response",__frameEvent);
         }
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",__onClickHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.removeEventListener("click",__onCancleClick);
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               close();
               break;
            case 1:
               close();
         }
      }
      
      protected function reArmyView(param1:BaseArmy) : void
      {
         var _loc3_:HeroCell = null;
         var _loc4_:PawnContain = null;
         if(!param1)
         {
            return;
         }
         _hBox.disposeAllChildren();
         if(param1.baseHero.id > 0)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("outercity.HeroCell");
            _loc3_.data = param1.baseHero;
            _loc3_.icon.icon = IconFactory.getHeadIcon(param1.baseHero.headId,"head");
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
            _hBox.addChild(_loc3_);
         }
         for each(var _loc2_:ArmyPawn in param1.armyPawns)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("outercity.PawnBaseCell");
            _loc4_.pawn = _loc2_;
            _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
            _hBox.addChild(_loc4_);
         }
         _hBox.refreshChildPos();
      }
      
      protected function get currentArmy() : BaseArmy
      {
         var _loc1_:BaseArmy = null;
         if(_info is WildLand)
         {
            _loc1_ = (_info as WildLand).ownSysArmy;
         }
         return _loc1_;
      }
      
      public function close() : void
      {
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
            KeyBoardRegister.instance.keyEnable = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_baseBackGround)
         {
            _baseBackGround.dispose();
         }
         _baseBackGround = null;
         if(_attackBtn)
         {
            _attackBtn.dispose();
         }
         _attackBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      public function get frameId() : uint
      {
         return _frameId;
      }
      
      public function get attackBtn() : BaseButton
      {
         return null;
      }
      
      public function get info() : WildLand
      {
         return _info as WildLand;
      }
   }
}

