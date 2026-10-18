package star.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StarEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.star.StarModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.StarManager;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class MakeStarView extends Sprite implements Disposeable
   {
      
      private var _instructionTxt:MovieClip;
      
      private var _freeCount:FilterFrameText;
      
      private var _starPointBtn:TextButton;
      
      private var _openStarShopBtn:TextButton;
      
      private var _crystalGroup:Vector.<MovieButton>;
      
      private var _crystalGroupLength:int;
      
      private var _greenCrystal:MovieButton;
      
      private var _whiteCrystal:MovieButton;
      
      private var _yellowCrystal:MovieButton;
      
      private var _redCrystal:MovieButton;
      
      private var _blueCrystal:MovieButton;
      
      private var _makeStarCosts:Array;
      
      private var _arrowGroup:Vector.<Bitmap>;
      
      private var _arrow1:Bitmap;
      
      private var _arrow2:Bitmap;
      
      private var _arrow3:Bitmap;
      
      private var _arrow4:Bitmap;
      
      private var _crystalGlow:MovieClip;
      
      private var _filter:UIFilter;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function MakeStarView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _colorMatrix = [0.4,0,0,0,6.1,0,0.4,0,0,6.1,0,0,0.4,0,6.1,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
         _makeStarCosts = [4000,5000,6000,8000,10000];
         _instructionTxt = ComponentFactory.Instance.creatCustomObject("star.InstructionTxt");
         _freeCount = ComponentFactory.Instance.creatComponentByStylename("star.FreeCountTxt");
         _freeCount.text = String(playerInfo.starFreeCount);
         _starPointBtn = ComponentFactory.Instance.creatComponentByStylename("star.StarPointBtn");
         _starPointBtn.enable = false;
         _starPointBtn.text = String(playerInfo.starPoint);
         _openStarShopBtn = ComponentFactory.Instance.creatComponentByStylename("star.OpenStarShopBtn");
         _openStarShopBtn.text = LanguageMgr.GetTranslation("star.view.MakeStarView.openStarShop");
         _crystalGlow = ComponentFactory.Instance.creatCustomObject("star.CrystalGlow");
         _greenCrystal = ComponentFactory.Instance.creatComponentByStylename("star.GreenCrystal");
         _whiteCrystal = ComponentFactory.Instance.creatComponentByStylename("star.WhiteCrystal");
         _yellowCrystal = ComponentFactory.Instance.creatComponentByStylename("star.YellowCrystal");
         _redCrystal = ComponentFactory.Instance.creatComponentByStylename("star.RedCrystal");
         _blueCrystal = ComponentFactory.Instance.creatComponentByStylename("star.BlueCrystal");
         _arrow1 = ComponentFactory.Instance.creatBitmap("asset.star.Arrow");
         _arrow1.x = 109;
         _arrow2 = ComponentFactory.Instance.creatBitmap("asset.star.Arrow");
         _arrow2.x = 202;
         _arrow3 = ComponentFactory.Instance.creatBitmap("asset.star.Arrow");
         _arrow3.x = 303;
         _arrow4 = ComponentFactory.Instance.creatBitmap("asset.star.Arrow");
         _arrow4.x = 399;
         _crystalGroup = new Vector.<MovieButton>();
         _crystalGroup.push(_greenCrystal);
         _crystalGroup.push(_whiteCrystal);
         _crystalGroup.push(_yellowCrystal);
         _crystalGroup.push(_redCrystal);
         _crystalGroup.push(_blueCrystal);
         _crystalGroupLength = _crystalGroup.length;
         _arrowGroup = new Vector.<Bitmap>();
         _arrowGroup.push(_arrow1);
         _arrowGroup.push(_arrow2);
         _arrowGroup.push(_arrow3);
         _arrowGroup.push(_arrow4);
         __updateCrystalHandler(null);
         addChild(_instructionTxt);
         addChild(_freeCount);
         addChild(_starPointBtn);
         addChild(_openStarShopBtn);
         addChild(_greenCrystal);
         addChild(_whiteCrystal);
         addChild(_yellowCrystal);
         addChild(_redCrystal);
         addChild(_blueCrystal);
         addChild(_arrow1);
         addChild(_arrow2);
         addChild(_arrow3);
         addChild(_arrow4);
         addChild(_crystalGlow);
         var _loc1_:String = "";
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(5);
         if(_loc2_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc2_);
            _bufferView.setDescText(_loc2_.tempInfo.Desc);
            _bufferView.x = 197;
            _bufferView.y = -52;
            addChild(_bufferView);
         }
         _greenCrystal.tipData = LanguageMgr.GetTranslation("star.view.MakeStarView.greenCrystal.tipData",1,_makeStarCosts[0],getMsBufferStr(_loc2_,1));
         _whiteCrystal.tipData = LanguageMgr.GetTranslation("star.view.MakeStarView.whiteCrystal.tipData",2,_makeStarCosts[1],getMsBufferStr(_loc2_,2));
         _yellowCrystal.tipData = LanguageMgr.GetTranslation("star.view.MakeStarView.yellowCrystal.tipData",3,_makeStarCosts[2],getMsBufferStr(_loc2_,3));
         _redCrystal.tipData = LanguageMgr.GetTranslation("star.view.MakeStarView.redCrystal.tipData",4,_makeStarCosts[3],getMsBufferStr(_loc2_,4));
         _blueCrystal.tipData = LanguageMgr.GetTranslation("star.view.MakeStarView.blueCrystal.tipData",5,_makeStarCosts[4],getMsBufferStr(_loc2_,4));
      }
      
      private function getMsBufferStr(param1:MagicSpringSlotInfo, param2:int) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc3_:int = int(_makeStarCosts[param2 - 1]);
         var _loc4_:int = Math.floor(param1.tempInfo.AddValue * _loc3_ / 100);
         return LanguageMgr.GetTranslation("MagicSpringFrame.buffer.reduceText",_loc4_);
      }
      
      public function getCrystalByIndex(param1:int) : MovieButton
      {
         return _crystalGroup[param1];
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         _openStarShopBtn.addEventListener("click",__openStarShopClickHandler);
         starManager.addEventListener("RANDOMPOS_CHANGE",__updateCrystalHandler);
         playerInfo.addEventListener("STAR_FREECOUNT_CHANGE",__starFreeCountChangeHandler);
         playerInfo.addEventListener("STAR_POINT_UPDATE",__starPointUpdateHandler);
         _loc1_ = 0;
         while(_loc1_ < _crystalGroupLength)
         {
            _crystalGroup[_loc1_].addEventListener("click",__CrystalClick);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _openStarShopBtn.removeEventListener("click",__openStarShopClickHandler);
         starManager.removeEventListener("RANDOMPOS_CHANGE",__updateCrystalHandler);
         playerInfo.removeEventListener("STAR_FREECOUNT_CHANGE",__starFreeCountChangeHandler);
         playerInfo.removeEventListener("STAR_POINT_UPDATE",__starPointUpdateHandler);
         _loc1_ = 0;
         while(_loc1_ < _crystalGroupLength)
         {
            _crystalGroup[_loc1_].removeEventListener("click",__CrystalClick);
            _loc1_++;
         }
      }
      
      private function __openStarShopClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.shopController.setPreFrame("star",null);
         FrameControllerManager.instance.openControllerByInfo("shop",101);
      }
      
      private function __starFreeCountChangeHandler(param1:PlayerEvent) : void
      {
         _freeCount.text = String(playerInfo.starFreeCount);
      }
      
      private function __starPointUpdateHandler(param1:PlayerEvent) : void
      {
         _starPointBtn.text = String(playerInfo.starPoint);
      }
      
      private function __updateCrystalHandler(param1:StarEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Array = starManager.randomPosList;
         var _loc3_:int = int(_loc4_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_[_loc2_] == 1)
            {
               _crystalGroup[_loc2_].mouseChildren = _crystalGroup[_loc2_].mouseEnabled = true;
               _crystalGroup[_loc2_].filters = null;
               _crystalGlow.x = _crystalGroup[_loc2_].x + 5;
               _crystalGlow.y = _crystalGroup[_loc2_].y + 2;
               if(_loc2_ >= 1)
               {
                  _filter.setNormalFilter(_arrowGroup[_loc2_ - 1]);
               }
            }
            else
            {
               _crystalGroup[_loc2_].mouseChildren = _crystalGroup[_loc2_].mouseEnabled = false;
               _crystalGroup[_loc2_].filters = [_colorFilter];
               if(_loc2_ >= 1)
               {
                  _filter.setGrayFilter(_arrowGroup[_loc2_ - 1]);
               }
            }
            _loc2_++;
         }
      }
      
      private function __CrystalClick(param1:MouseEvent) : void
      {
         var _loc3_:int = _crystalGroup.indexOf(param1.currentTarget);
         var _loc2_:String = "";
         if(playerInfo.starFreeCount <= 0 && ResourceManager.instance.gold.count < 20000)
         {
            _loc2_ = LanguageMgr.GetTranslation("star.view.MakeStarView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(playerInfo.starFreeCount <= 0 && ResourceManager.instance.gold.count < _makeStarCosts[_loc3_])
         {
            _loc2_ = LanguageMgr.GetTranslation("star.view.MakeStarView.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(starManager.tempStarList.getList().length >= 18)
         {
            _loc2_ = LanguageMgr.GetTranslation("star.view.MakeStarView.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("026",true);
         starManager.sendRandomStar(_loc3_);
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      private function get starModel() : StarModel
      {
         return StarManager.instance.starModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         var _loc1_:MovieButton = null;
         removeEvent();
         ObjectUtils.disposeViolentMc(_instructionTxt);
         _instructionTxt = null;
         ObjectUtils.disposeObject(_freeCount);
         _freeCount = null;
         ObjectUtils.disposeObject(_starPointBtn);
         _starPointBtn = null;
         ObjectUtils.disposeObject(_openStarShopBtn);
         _openStarShopBtn = null;
         ObjectUtils.disposeViolentMc(_greenCrystal);
         _greenCrystal = null;
         ObjectUtils.disposeViolentMc(_whiteCrystal);
         _whiteCrystal = null;
         ObjectUtils.disposeViolentMc(_yellowCrystal);
         _yellowCrystal = null;
         ObjectUtils.disposeViolentMc(_redCrystal);
         _redCrystal = null;
         ObjectUtils.disposeViolentMc(_blueCrystal);
         _blueCrystal = null;
         ObjectUtils.disposeViolentMc(_crystalGlow);
         _crystalGlow = null;
         ObjectUtils.disposeObject(_arrow1);
         _arrow1 = null;
         ObjectUtils.disposeObject(_arrow2);
         _arrow2 = null;
         ObjectUtils.disposeObject(_arrow3);
         _arrow3 = null;
         ObjectUtils.disposeObject(_arrow4);
         _arrow4 = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         while(_crystalGroup.length > 0)
         {
            _loc1_ = _crystalGroup.pop();
            ObjectUtils.disposeViolentMc(_loc1_);
            _loc1_ = null;
         }
         _crystalGroup = null;
         _makeStarCosts = null;
         _arrowGroup = null;
         _filter = null;
         _colorFilter = null;
         _colorMatrix = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

