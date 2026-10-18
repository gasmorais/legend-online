package gamehall.room
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FreedomTeamEvent;
   import events.GameHallEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallBlessInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.gamehall.GameHallTeamInfo;
   import mvc.module.gamehall.GameHallUserInfo;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class GameHallSceneEastBlessView extends Sprite
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _playerInfoBg:MutipleImage;
      
      private var _bossInfoBg:MutipleImage;
      
      private var _descTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _hideBtn:BaseButton;
      
      private var _showBtn:BaseButton;
      
      private var _blessHBox:HBox;
      
      private var _endBlessHBox:HBox;
      
      private var _model:GameHallModel;
      
      private var _data:GameHallTeamInfo;
      
      private var _gameHallBuyBufferView:GameHallBuyBufferView;
      
      public function GameHallSceneEastBlessView()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.border");
         _playerInfoBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.playerInfoBg");
         _bossInfoBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.bossInfoBg");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.descTxt");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.vbox");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.hideBtn");
         _showBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.showBtn");
         _blessHBox = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.blessHBox");
         _endBlessHBox = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessView.endBlessHBox");
         _gameHallBuyBufferView = new GameHallBuyBufferView();
         addChild(_border);
         addChild(_playerInfoBg);
         addChild(_bossInfoBg);
         addChild(_descTxt);
         addChild(_vbox);
         addChild(_hideBtn);
         addChild(_showBtn);
         addChild(_blessHBox);
         addChild(_endBlessHBox);
         addChild(_gameHallBuyBufferView);
         _gameHallBuyBufferView.x = 10;
         _gameHallBuyBufferView.y = 385;
         _hideBtn.visible = true;
         _showBtn.visible = false;
         _descTxt.text = LanguageMgr.GetTranslation("gamehall.room.GameHallSceneEastBlessView.descTxt");
      }
      
      public function get buffBtn() : BaseButton
      {
         return _gameHallBuyBufferView.buyBuffBtn;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_playerInfoBg);
         _playerInfoBg = null;
         ObjectUtils.disposeObject(_bossInfoBg);
         _bossInfoBg = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_blessHBox);
         _blessHBox = null;
         ObjectUtils.disposeObject(_endBlessHBox);
         _endBlessHBox = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_showBtn);
         _showBtn = null;
         ObjectUtils.disposeObject(_gameHallBuyBufferView);
         _gameHallBuyBufferView = null;
      }
      
      private function initEvent() : void
      {
         if(_hideBtn)
         {
            _hideBtn.addEventListener("click",__hideBtnHandler);
         }
         if(_showBtn)
         {
            _showBtn.addEventListener("click",__showBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_BUFFERINFO",__updateBufferHandler);
         }
         if(_model)
         {
            _model.addEventListener("SELECTED_GAME_INFO_UPDATE",__updateBufferHandler);
         }
         if(_model)
         {
            _model.addEventListener("USER_INFO_UPDATE",__updateUserInfoHandler);
         }
         if(_model)
         {
            _model.addEventListener("GAME_INFO_UPDATE",__updateUserInfoHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_WISHINFO",__updateUserSelfBufferHandler);
         }
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__hideBtnHandler);
         }
         if(_showBtn)
         {
            _showBtn.removeEventListener("click",__showBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_BUFFERINFO",__updateBufferHandler);
         }
         if(_model)
         {
            _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__updateBufferHandler);
         }
         if(_model)
         {
            _model.removeEventListener("USER_INFO_UPDATE",__updateUserInfoHandler);
         }
         if(_model)
         {
            _model.removeEventListener("GAME_INFO_UPDATE",__updateUserInfoHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_WISHINFO",__updateUserSelfBufferHandler);
         }
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
      }
      
      private function __hideBtnHandler(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(this);
         TweenLite.to(this,1,{
            "x":StageReferance.stageWidth,
            "onComplete":completeTween
         });
         _showBtn.visible = true;
         _hideBtn.visible = false;
      }
      
      private function completeTween() : void
      {
         TweenLite.killTweensOf(this);
      }
      
      private function __showBtnHandler(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(this);
         TweenLite.to(this,1,{
            "x":StageReferance.stageWidth - 222,
            "onComplete":completeTween
         });
         _showBtn.visible = false;
         _hideBtn.visible = true;
      }
      
      private function __updateBufferHandler(param1:GameHallEvent) : void
      {
         if(GameHallManager.instance.model.selfArmy)
         {
            refreshView();
         }
      }
      
      private function __updateUserSelfBufferHandler(param1:GameHallEvent) : void
      {
         if(GameHallManager.instance.model.selfArmy)
         {
            if(_gameHallBuyBufferView)
            {
               _gameHallBuyBufferView.refrehView();
            }
         }
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         if(GameHallManager.instance.model.selfArmy)
         {
            refreshView();
         }
      }
      
      private function __updateUserInfoHandler(param1:GameHallEvent) : void
      {
         if(GameHallManager.instance.model.selfArmy)
         {
            refreshView();
         }
      }
      
      public function refreshView() : void
      {
         if(_model.gameId == 4)
         {
            refreshPlayerInfo();
            refreshBossInfo();
            refreshEndBuffInfo();
            if(_gameHallBuyBufferView)
            {
               _gameHallBuyBufferView.refrehView();
            }
         }
      }
      
      private function refreshPlayerInfo() : void
      {
         var _loc1_:GameHallSceneEastBlessItem = null;
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_vbox)
         {
            _vbox.removeAllChild();
         }
         if(_model.selfTeam)
         {
            _loc3_ = _model.selfTeam.players;
            _loc2_ = int(_loc3_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = new GameHallSceneEastBlessItem();
               _loc1_.tipsType = 1;
               _loc1_.data = _loc3_[_loc4_];
               if(_vbox)
               {
                  _vbox.addChild(_loc1_);
               }
               _loc4_++;
            }
         }
      }
      
      private function refreshBossInfo() : void
      {
         var _loc7_:String = null;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:GameHallBlessInfo = null;
         var _loc2_:GameHallSceneEastBlessBaseItemView = null;
         var _loc6_:int = 0;
         if(_blessHBox)
         {
            _blessHBox.removeAllChild();
         }
         var _loc1_:GameHallEasterTemplateInfo = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_model.selfTeam.difficulty);
         if(_loc1_)
         {
            _loc7_ = _loc1_.Buff3;
            if(_loc7_)
            {
               _loc5_ = _loc7_.split(",");
               _loc3_ = int(_loc5_.length);
               _loc6_ = 0;
               while(_loc6_ < _loc3_)
               {
                  _loc2_ = new GameHallSceneEastBlessBaseItemView();
                  _loc4_ = new GameHallBlessInfo();
                  _loc4_.skillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc5_[_loc6_]);
                  _loc2_.showCurrentLevel = false;
                  _loc2_.data = _loc4_;
                  if(_blessHBox)
                  {
                     _blessHBox.addChild(_loc2_);
                  }
                  _loc6_++;
               }
            }
         }
      }
      
      private function copyArray(param1:Array) : Array
      {
         var _loc2_:GameHallBlessInfo = null;
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         if(!param1)
         {
            return [];
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new GameHallBlessInfo();
            _loc2_.level = (param1[_loc3_] as GameHallBlessInfo).level;
            _loc2_.skillTempInfo = (param1[_loc3_] as GameHallBlessInfo).skillTempInfo;
            _loc4_.push(_loc2_);
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function refreshEndBuffInfo() : void
      {
         var _loc18_:int = 0;
         var _loc20_:Array = null;
         var _loc1_:Dictionary = null;
         var _loc10_:int = 0;
         var _loc23_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:GameHallBlessInfo = null;
         var _loc5_:GameHallBlessInfo = null;
         var _loc6_:int = 0;
         var _loc16_:GameHallEasterTemplateInfo = null;
         var _loc21_:String = null;
         var _loc19_:Array = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc8_:SkillTempInfo = null;
         var _loc12_:int = 0;
         var _loc22_:int = 0;
         var _loc13_:GameHallBlessInfo = null;
         var _loc3_:Boolean = false;
         var _loc9_:int = 0;
         var _loc17_:GameHallSceneEastBlessBaseItemView = null;
         if(_endBlessHBox)
         {
            _endBlessHBox.removeAllChild();
         }
         var _loc7_:Vector.<GameHallUserInfo> = _model.selfTeam.players;
         if(_loc7_)
         {
            _loc18_ = int(_loc7_.length);
            _loc1_ = new Dictionary();
            _loc10_ = 0;
            while(_loc10_ < _loc18_)
            {
               _loc20_ = copyArray((_loc7_[_loc10_] as GameHallUserInfo).buffs);
               if(_loc20_)
               {
                  _loc23_ = int(_loc20_.length);
                  _loc11_ = 0;
                  while(_loc11_ < _loc23_)
                  {
                     _loc2_ = _loc20_[_loc11_] as GameHallBlessInfo;
                     if(_loc2_ && _loc2_.skillTempInfo)
                     {
                        if(_loc1_[_loc2_.skillTempInfo.TemplateId])
                        {
                           _loc5_ = _loc1_[_loc2_.skillTempInfo.TemplateId];
                           _loc6_ = int(_loc5_.level);
                           _loc5_.level = _loc6_ + _loc2_.level;
                           _loc1_[_loc2_.skillTempInfo.TemplateId] = _loc5_;
                        }
                        else
                        {
                           _loc1_[_loc2_.skillTempInfo.TemplateId] = _loc2_;
                        }
                     }
                     _loc11_++;
                  }
               }
               _loc10_++;
            }
            _loc16_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_model.selfTeam.difficulty);
            if(_loc16_)
            {
               _loc21_ = _loc16_.Buff3;
               _loc19_ = _loc21_.split(",");
               if(_loc19_)
               {
                  _loc14_ = int(_loc19_.length);
               }
            }
            _loc10_ = 0;
            while(_loc10_ < _loc14_)
            {
               _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc19_[_loc10_]);
               if(_loc8_)
               {
                  _loc9_ = int(_loc8_.SonType);
               }
               for each(var _loc4_:GameHallBlessInfo in _loc1_)
               {
                  if(_loc4_ && _loc4_.skillTempInfo && _loc4_.skillTempInfo.SonType == _loc9_)
                  {
                     _loc12_ = int(_loc8_.Grades);
                     if(_loc4_.level != 0)
                     {
                        _loc22_ = _loc8_.TemplateId - int(_loc4_.level / 5);
                     }
                     else
                     {
                        _loc22_ = int(_loc8_.TemplateId);
                     }
                     if(_loc8_.Index == 1)
                     {
                        if(_loc22_ < 9201000)
                        {
                           _loc22_ = 9201000;
                        }
                     }
                     else if(_loc8_.Index == 2)
                     {
                        if(_loc22_ < 9202000)
                        {
                           _loc22_ = 9202000;
                        }
                     }
                     else if(_loc8_.Index == 3)
                     {
                        if(_loc22_ < 9203000)
                        {
                           _loc22_ = 9203000;
                        }
                     }
                     else if(_loc8_.Index == 4)
                     {
                        if(_loc22_ < 9204000)
                        {
                           _loc22_ = 9204000;
                        }
                     }
                     _loc15_ = _loc12_ - _loc4_.level;
                     _loc15_ = int(_loc15_ >= 0 ? _loc15_ : 0);
                     _loc13_ = new GameHallBlessInfo();
                     _loc13_.skillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc22_);
                     _loc13_.level = _loc15_;
                     _loc17_ = new GameHallSceneEastBlessBaseItemView();
                     _loc17_.showCurrentLevel = false;
                     _loc17_.tipsType = 2;
                     _loc17_.data = _loc13_;
                     if(_endBlessHBox)
                     {
                        _endBlessHBox.addChild(_loc17_);
                     }
                     break;
                  }
               }
               _loc10_++;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

