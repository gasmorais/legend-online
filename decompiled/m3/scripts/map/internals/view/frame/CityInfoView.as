package map.internals.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.data.BaseCastle;
   import map.internals.interfaces.IOuterFrame;
   import map.outercity.manager.OuterCityManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.service.services.AmfResponder;
   import yishi.utils.ClassFactory;
   import yishi.view.tips.MessageTipManager;
   
   public class CityInfoView extends Sprite implements IOuterFrame
   {
      
      private var _frameId:uint;
      
      private var _frame:Frame;
      
      private var _info:BaseCastle;
      
      protected var _moveBtn:TextButton;
      
      protected var _attackBtn:TextButton;
      
      private var _loadIcon:DisplayObject;
      
      private var _backGround:ScaleBitmapImage;
      
      private var _medianLineImg:Bitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _lordText:FilterFrameText;
      
      private var _politeText:FilterFrameText;
      
      private var _lordText2:FilterFrameText;
      
      private var _politeText2:FilterFrameText;
      
      public function CityInfoView()
      {
         super();
         _frameId = 1;
         init();
      }
      
      private function init() : void
      {
         _backGround = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.CityContentBgAsset");
         addChild(_backGround);
         _medianLineImg = ComponentFactory.Instance.creatBitmap("asset.outercity.medianLineImg");
         addChild(_medianLineImg);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("outercity.FrameOutercityNameText");
         _nameText.mouseEnabled = true;
         _nameText.selectable = false;
         addChild(_nameText);
         _lordText = ComponentFactory.Instance.creatComponentByStylename("outercity.FrameLordText");
         _lordText.text = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command01");
         addChild(_lordText);
         _lordText2 = ComponentFactory.Instance.creatComponentByStylename("outercity.FrameLordTextInput");
         addChild(_lordText2);
         _politeText = ComponentFactory.Instance.creatComponentByStylename("outercity.FramePoliteText");
         _politeText.text = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command02");
         addChild(_politeText);
         _politeText2 = ComponentFactory.Instance.creatComponentByStylename("outercity.FramePoliteTextInput");
         addChild(_politeText2);
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.CityAttackBtnAsset");
         _attackBtn.text = LanguageMgr.GetTranslation("public.attack");
         addChild(_attackBtn);
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.CityMoveBtnAsset");
         _moveBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addChild(_moveBtn);
      }
      
      private function __playerNameClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ThaneInfo = null;
         if(_info.info.occupyPlayerId >= 1900000000)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_info.info.occupyPlayerId == _loc4_.userId)
         {
            PlayerInfoManager.instance.show(ArmyManager.instance.thane);
         }
         else
         {
            _loc3_ = new ThaneInfo();
            _loc3_.userId = _info.info.occupyPlayerId;
            _loc3_.nickName = _info.info.names;
            _loc3_.job = 2;
            PlayerInfoManager.instance.show(_loc3_);
         }
      }
      
      private function __receivePlayerInfo(param1:AmfResponder) : void
      {
         if(!param1.result)
         {
            return;
         }
         var _loc2_:PlayerInfo = ClassFactory.createInstance(PlayerInfo,param1.result);
         showPlayerProperty(_loc2_);
      }
      
      private function showPlayerProperty(param1:PlayerInfo) : void
      {
      }
      
      protected function __moveHandler(param1:MouseEvent) : void
      {
      }
      
      protected function __attackHandler(param1:MouseEvent) : void
      {
      }
      
      private function loadMovie() : void
      {
         var _loc1_:String = PathManager.solveMapPhysicsBySonType(_info.sonType);
         LoaderManagerII.instance.load(_loc1_,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!_info)
         {
            return;
         }
         _loadIcon = param2 as DisplayObject;
         addChild(_loadIcon);
         _loadIcon.x = 285;
         _loadIcon.y = 70;
      }
      
      private function removeLoad() : void
      {
         ObjectUtils.disposeViolentMc(_loadIcon as DisplayObjectContainer);
         _loadIcon = null;
      }
      
      private function setInfoToView() : void
      {
         _nameText.htmlText = "<a href =\'event: \'><b><u>" + String(_info.info.names) + "(" + _info.convertX + "," + _info.convertY + ")" + "</b></u></a>";
         _lordText2.text = _info.info.names;
         _politeText2.text = _info.info.occupyLeagueName ? _info.info.occupyLeagueName : LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.politeText2.none");
         loadMovie();
         if(PlayerManager.instance.currentPlayerModel.playerInfo.userId == _info.info.occupyPlayerId)
         {
            _attackBtn.text = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command06");
            return;
         }
         if(_info.info.occupyPlayerId != 0)
         {
            _moveBtn.text = LanguageMgr.GetTranslation("public.cancel");
            _attackBtn.text = LanguageMgr.GetTranslation("public.attack");
         }
         else if(_info.info.occupyPlayerId == 0)
         {
            _moveBtn.text = LanguageMgr.GetTranslation("public.cancel");
            _attackBtn.text = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command07");
         }
      }
      
      public function show(param1:Object) : void
      {
         _info = param1 as BaseCastle;
         setInfoToView();
         if(!_frame)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.CityFrame");
         }
         KeyBoardRegister.instance.keyEnable = false;
         _frame.beginChanges();
         if(_info.info.occupyPlayerId == 0)
         {
            _frame.titleText = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command08");
         }
         else
         {
            _frame.titleText = LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command09");
         }
         _frame.commitChanges();
         _frame.addToContent(this);
         LayerManager.Instance.addToLayer(_frame,3,true,true,1);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _moveBtn.addEventListener("click",__moveHandler);
         _attackBtn.addEventListener("click",__attackHandler);
         _nameText.addEventListener("click",__playerNameClickHandler);
         _frame.addEventListener("response",__frameEvent);
      }
      
      private function removeEvent() : void
      {
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",__moveHandler);
         }
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",__attackHandler);
         }
         if(_nameText)
         {
            _nameText.removeEventListener("click",__playerNameClickHandler);
         }
         if(_frame)
         {
            _frame.removeEventListener("response",__frameEvent);
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
      
      public function dispose() : void
      {
         removeEvent();
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         _info = null;
         if(_moveBtn)
         {
            _moveBtn.dispose();
         }
         _moveBtn = null;
         if(_attackBtn)
         {
            _attackBtn.dispose();
         }
         _attackBtn = null;
         if(_backGround)
         {
            _backGround.dispose();
         }
         _backGround = null;
         if(_medianLineImg)
         {
            if(_medianLineImg.parent)
            {
               _medianLineImg.parent.removeChild(_medianLineImg);
            }
            _medianLineImg.bitmapData.dispose();
         }
         _medianLineImg = null;
         if(_nameText)
         {
            _nameText.dispose();
         }
         _nameText = null;
         if(_lordText)
         {
            _lordText.dispose();
         }
         _lordText = null;
         if(_politeText)
         {
            _politeText.dispose();
         }
         _politeText = null;
         if(_lordText2)
         {
            _lordText2.dispose();
         }
         _lordText2 = null;
         if(_politeText2)
         {
            _politeText2.dispose();
         }
         _politeText2 = null;
         removeLoad();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function close() : void
      {
         OuterCityManager.instance.model.walkTargerData = null;
         if(_frame && _frame.parent)
         {
            KeyBoardRegister.instance.keyEnable = true;
            _frame.parent.removeChild(_frame);
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
      
      public function get baseCastle() : BaseCastle
      {
         return _info;
      }
   }
}

