package landmine
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.landmine.LandMineSapperInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.view.tools.PetFormationMovieClip;
   import yishi.view.tools.QuickenMovieClip;
   
   public class LandMineHeroView extends Component
   {
      
      private var _roleContainer:Sprite;
      
      private var _nameTxt:FilterFrameText;
      
      private var _heroMovie:PetFormationMovieClip;
      
      private var _moveEffectMC:MovieClip;
      
      private var _moveEffectView:QuickenMovieClip;
      
      private var _trapEffectMC:MovieClip;
      
      private var _trapEffectView:QuickenMovieClip;
      
      private var _showMoveEffect:Boolean = true;
      
      private var _showTrapEffect:Boolean = true;
      
      private var _actionCache:Vector.<LandMineSapperInfo> = new Vector.<LandMineSapperInfo>();
      
      private var _actionFlag:Boolean = false;
      
      private var _actionSkip:Boolean = false;
      
      private var _actionMove:Boolean = false;
      
      private var _actionData:LandMineSapperInfo;
      
      private var _actionCallBack:Function;
      
      private var _moveEffectCallBack:Function;
      
      private var _trapEffectCallBack:Function;
      
      private var _data:LandMineSapperInfo;
      
      private var _isInit:Boolean = false;
      
      public function LandMineHeroView(param1:Function, param2:Function, param3:Function)
      {
         _actionCallBack = param1;
         _moveEffectCallBack = param2;
         _trapEffectCallBack = param3;
         super();
         initView();
         addEvent();
         mouseEnabled = mouseChildren = false;
      }
      
      private function initView() : void
      {
         _roleContainer = ComponentFactory.Instance.creatCustomObject("landmine.LandMineHeroView.roleContainer");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineHeroView.nameTxt");
         _moveEffectMC = ComponentFactory.Instance.creatCustomObject("landmine.LandMineHeroView.moveEffectMC");
         _moveEffectView = new QuickenMovieClip(_moveEffectMC);
         _moveEffectView.gotoAndStop(1);
         _moveEffectView.addFrameScript(_moveEffectView.totalFrames - 1,moveEffectViewPlayerComplete);
         _moveEffectView.mouseEnabled = _moveEffectView.mouseChildren = false;
         _moveEffectView.visible = false;
         _trapEffectMC = ComponentFactory.Instance.creatCustomObject("landmine.LandMineHeroView.trapEffectMC");
         _trapEffectView = new QuickenMovieClip(_trapEffectMC);
         _trapEffectView.gotoAndStop(1);
         _trapEffectView.addFrameScript(_trapEffectView.totalFrames - 1,trapEffectViewPlayerComplete);
         _trapEffectView.mouseEnabled = _trapEffectView.mouseChildren = false;
         _trapEffectView.visible = false;
         addChild(_roleContainer);
         addChild(_nameTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_moveEffectMC);
         ObjectUtils.disposeViolentMc(_trapEffectMC);
         ObjectUtils.disposeAllChildren(_roleContainer);
         ObjectUtils.disposeObject(_roleContainer);
         _roleContainer = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_heroMovie);
         _heroMovie = null;
         ObjectUtils.disposeObject(_moveEffectMC);
         _moveEffectMC = null;
         ObjectUtils.disposeObject(_moveEffectView);
         _moveEffectView = null;
         ObjectUtils.disposeObject(_trapEffectMC);
         _trapEffectMC = null;
         ObjectUtils.disposeObject(_trapEffectView);
         _trapEffectView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function updateHeroView() : void
      {
         var _loc1_:ThaneInfo = null;
         var _loc2_:HeroRoleInfo = null;
         if(!_isInit)
         {
            _isInit = true;
            _loc1_ = new ThaneInfo();
            _loc1_.userId = data.userId;
            _loc1_.sexs = data.sex;
            _loc1_.nickName = data.nickName;
            _loc1_.templateId = data.templateId;
            _loc1_.armsEquipAvata = data.arm;
            _loc1_.wingAvata = data.wing;
            _loc1_.hairFashionAvata = data.hat;
            _loc1_.bodyEquipAvata = data.cloth;
            _loc1_.armsFashionAvata = data.fashionArm;
            _loc1_.bodyFashionAvata = data.fashionCloth;
            _loc1_.hideFashion = data.hide;
            _nameTxt.text = _loc1_.nickName;
            _loc2_ = new HeroRoleInfo();
            _loc2_.heroInfo = _loc1_;
            _loc2_.heroInfo.dragonTalkerInfo.isDragonTalker = data.isDragonTalker;
            _loc2_.heroInfo.dragonTalkerInfo.battleBeastId = PathManager.isShowDragon(_loc2_.heroInfo) ? data.battleBeastId : 0;
            _heroMovie = new PetFormationMovieClip(_loc2_,true);
            _heroMovie.callBackComplete.addSingleListener(heroMovieClipLoadComplete);
            _heroMovie.startLoad();
         }
      }
      
      private function heroMovieClipLoadComplete() : void
      {
         if(_heroMovie)
         {
            _heroMovie.x = 40;
            _heroMovie.y = 15;
            _heroMovie.mouseChildren = _heroMovie.mouseEnabled = false;
            _roleContainer.addChild(_heroMovie);
            _heroMovie.gotoAndPlay(1);
            _actionMove = true;
         }
      }
      
      public function get moveEffectView() : QuickenMovieClip
      {
         return _moveEffectView;
      }
      
      public function get trapEffectView() : QuickenMovieClip
      {
         return _trapEffectView;
      }
      
      public function get heroMovie() : PetFormationMovieClip
      {
         return _heroMovie;
      }
      
      public function get data() : LandMineSapperInfo
      {
         return _data;
      }
      
      public function set data(param1:LandMineSapperInfo) : void
      {
         _data = param1;
         if(data)
         {
            updateHeroView();
         }
      }
      
      private function get self() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set showMoveEffect(param1:Boolean) : void
      {
         _showMoveEffect = param1;
      }
      
      public function set showTrapEffect(param1:Boolean) : void
      {
         _showTrapEffect = param1;
      }
      
      public function get actionFlag() : Boolean
      {
         return _actionFlag;
      }
      
      public function action(param1:LandMineSapperInfo) : void
      {
         _actionCache.push(param1);
         if(_actionFlag)
         {
            _actionSkip = true;
         }
         else
         {
            actionNext();
         }
      }
      
      private function actionNext() : void
      {
         _actionFlag = true;
         _actionData = _actionCache.shift();
         readyToMove();
      }
      
      private function actionLast() : void
      {
         swapActionData();
         readyToMove();
      }
      
      private function swapActionData() : void
      {
         _actionSkip = false;
         if(_actionCache.length > 0)
         {
            _actionFlag = true;
            _actionData = _actionCache.pop();
            _actionCache.splice(0,_actionCache.length);
         }
      }
      
      private function actionOver() : void
      {
         if(_actionCallBack != null)
         {
            _actionCallBack();
         }
         _actionFlag = false;
      }
      
      private function readyToMove() : void
      {
         if(_actionData != null)
         {
            data.posX = _actionData.posX;
            data.posY = _actionData.posY;
            data.state = _actionData.state;
         }
         if(_actionMove)
         {
            heroMovie.addTagFinalFrameScript("Ready",readyToMoveCallBack);
            heroMovie.gotoAndPlay("Ready");
         }
         else
         {
            readyToMoveCallBack();
         }
      }
      
      private function readyToMoveCallBack() : void
      {
         moveHeroView();
      }
      
      private function moveHeroView() : void
      {
         if(_actionMove)
         {
            heroMovie.gotoAndPlay("Stand");
         }
         if(_actionSkip)
         {
            swapActionData();
         }
         this.x = _actionData.targetPosition.x;
         this.y = _actionData.targetPosition.y;
         if(_showMoveEffect)
         {
            moveEffectView.x = this.x;
            moveEffectView.y = this.y;
            moveEffectView.visible = true;
            moveEffectView.gotoAndPlay(1);
         }
         else
         {
            moveEffectViewPlayerComplete();
         }
      }
      
      private function moveEffectViewPlayerComplete() : void
      {
         moveEffectView.visible = false;
         if(_actionData)
         {
            if(_actionData.state == 1)
            {
               trapShow();
            }
            else
            {
               checkAction();
            }
         }
         else
         {
            checkAction();
         }
      }
      
      private function trapShow() : void
      {
         if(_actionMove)
         {
            heroMovie.gotoAndPlay("Danny");
         }
         if(_showTrapEffect)
         {
            trapEffectView.x = _actionData.centerPosition.x;
            trapEffectView.y = _actionData.centerPosition.y;
            trapEffectView.visible = true;
            trapEffectView.gotoAndPlay(1);
         }
         else
         {
            trapEffectViewPlayerComplete();
         }
      }
      
      private function trapEffectViewPlayerComplete() : void
      {
         trapEffectView.visible = false;
         if(_actionMove)
         {
            heroMovie.gotoAndPlay("Failed");
         }
         checkAction(true);
      }
      
      private function checkAction(param1:Boolean = false) : void
      {
         if(_actionCache.length > 0)
         {
            if(_actionSkip)
            {
               actionLast();
            }
            else
            {
               actionNext();
            }
            return;
         }
         actionOver();
         if(param1)
         {
            if(_trapEffectCallBack != null)
            {
               _trapEffectCallBack(_actionData);
            }
         }
         else if(_moveEffectCallBack != null)
         {
            _moveEffectCallBack(_actionData);
         }
         _actionData = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

