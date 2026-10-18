package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class LevelUpViewII extends Component implements IEnterFrame
   {
      
      private var _levelContain:MovieClip;
      
      private var _levelTxtContain:MovieClip;
      
      private var _levelNum:BitmapData;
      
      private var _vocationTxtStep:ScaleFrameImage;
      
      private var _vocationTxtJob:ScaleFrameImage;
      
      private var _isVocation:Boolean;
      
      private var _count:int;
      
      public function LevelUpViewII(param1:Boolean = false)
      {
         super();
         _isVocation = param1;
         initView();
      }
      
      private function initView() : void
      {
         mouseEnabled = mouseChildren = false;
         _levelTxtContain = ComponentFactory.Instance.creatCustomObject("asset.playerlevelup.LelveUpLeveltxtContain");
         _levelNum = ComponentFactory.Instance.creatBitmapData("asset.playerlevelup.NumStyle01");
         var _loc1_:int = playerInfo.vocationStep;
         var _loc2_:int = playerInfo.vocationLevel;
         var _loc4_:int = thane.templateInfo.Job;
         var _loc3_:int = thane.grades;
         if(_isVocation)
         {
            _levelContain = ComponentFactory.Instance.creatCustomObject("asset.playerlevelup.LelveUpVocationContain");
            _vocationTxtJob = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LevelUpVocationTxtJob" + _loc4_);
            _vocationTxtJob.setFrame(_loc2_);
            _levelTxtContain.contain.addChild(_vocationTxtJob);
            _levelTxtContain.x = 313;
            _levelTxtContain.y = -74;
            NumberViewUtils.refreshValue(_loc1_,_levelTxtContain.contain,_levelNum,48,70,48,48,"1234567890");
         }
         else
         {
            _levelContain = ComponentFactory.Instance.creatCustomObject("asset.playerlevelup.LelveUpLevelContain");
            NumberViewUtils.refreshValue(_loc3_,_levelTxtContain.contain,_levelNum,48,70,48,48,"1234567890");
            _levelContain["content"].gotoAndStop(_loc3_ < 10 ? 1 : 2);
            _levelTxtContain.x = 305;
            _levelTxtContain.y = -85;
         }
         _levelContain.gotoAndStop(1);
         _levelTxtContain.gotoAndStop(1);
         addChild(_levelContain);
         addChild(_levelTxtContain);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,true);
         EnterFrameManager.instance.registeEnterFrame(this);
         startPlay();
      }
      
      public function enterFrame() : void
      {
         _count = _count + 1;
         if(_count > 100)
         {
            dispose();
         }
      }
      
      private function startPlay() : void
      {
         _levelContain.gotoAndPlay(1);
         _levelTxtContain.gotoAndPlay(1);
      }
      
      public function play() : void
      {
         _levelContain.play();
         _levelTxtContain.play();
      }
      
      public function stop() : void
      {
         _levelContain.stop();
         _levelTxtContain.stop();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         ObjectUtils.disposeViolentMc(_levelContain);
         _levelContain = null;
         ObjectUtils.disposeViolentMc(_levelTxtContain);
         _levelTxtContain = null;
         ObjectUtils.disposeObject(_levelNum);
         _levelNum = null;
         ObjectUtils.disposeObject(_vocationTxtStep);
         _vocationTxtStep = null;
         ObjectUtils.disposeObject(_vocationTxtJob);
         _vocationTxtJob = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

