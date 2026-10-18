package war2023.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.ui.SecretwarNodeUI;
   import war2023.util.SecretwarBitDataUtil;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarNodeView extends SecretwarNodeUI implements IEnterFrame
   {
      
      private var _data:SecretWarNodeInfo;
      
      private var _isEvent:Boolean = false;
      
      private var _childView:SecretwarNodePlayListView;
      
      private var _stateFlg:Bitmap;
      
      private var _selfCamp:int;
      
      private var _state:int = -1;
      
      public function SecretwarNodeView()
      {
         super();
         _selfCamp = model.selfPlay.camp;
         var _loc1_:Array = model.nodeScoreParms;
         _nodeScoreTxt.htmlText = LanguageMgr.GetTranslation("secretwar.node.score",_loc1_[0],_loc1_[2]);
         _childView = new SecretwarNodePlayListView();
         _stateFlg = new Bitmap();
         addChild(_stateFlg);
         addChild(_childView);
         _childView.x = -16;
         _childView.y = 166;
         initEvent();
      }
      
      public function enterFrame() : void
      {
         if(!_data)
         {
            return;
         }
         switch(int(_data.type) - 3)
         {
            case 0:
               _NodePlayNum.x = 43;
               _NodePlayNum.y = 124;
               _house2.x = 10;
               _house2.y = -26;
               break;
            case 1:
               _NodePlayNum.x = 43;
               _NodePlayNum.y = 124;
               _house2.x = 10;
               _house2.y = -26;
               break;
            default:
               _house2.x = 15;
               _house2.y = 29;
               if(_data.isFigting)
               {
                  _NodePlayNum.text = LanguageMgr.GetTranslation("secretwar.stateFight");
               }
               else
               {
                  _NodePlayNum.text = LanguageMgr.GetTranslation("secretwar.stateNo");
               }
               updateStateView();
         }
         _childView.data = _data;
         _childView.enterFrame();
         state = _data.state;
      }
      
      private function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         switch(_state)
         {
            case 0:
               _stateFlg.bitmapData = SecretwarBitDataUtil.getPeaceFlg(_data.camp);
               _stateFlg.x = 18;
               _stateFlg.y = 91;
               break;
            case 4:
            case 6:
               _stateFlg.bitmapData = SecretwarBitDataUtil.fightFlg;
               _stateFlg.x = 15;
               _stateFlg.y = 91;
               break;
            case 5:
               _stateFlg.bitmapData = SecretwarBitDataUtil.getDefFlg(_data.camp);
               _stateFlg.x = 23;
               _stateFlg.y = 93;
               break;
            default:
               _stateFlg.bitmapData = null;
               _NodePlayNum.text = LanguageMgr.GetTranslation("secretwar.noFight");
         }
      }
      
      private function updateStateView() : void
      {
         var _loc2_:SecretwarPlayInfo = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in _data.allPlayerList)
         {
            if(_loc2_.state == 4 || _loc2_.state == 6)
            {
               _loc1_ = true;
               break;
            }
         }
         if(_loc1_)
         {
            _nodeStateTxt.setFrame(2);
            _nodeStateTxt.text = LanguageMgr.GetTranslation("secretwar.stateFight");
         }
         else
         {
            _nodeStateTxt.setFrame(1);
            _nodeStateTxt.text = LanguageMgr.GetTranslation("secretwar.stateNo");
         }
         _loc2_ = _data.allPlayerList[0];
         if(_loc2_ && _loc2_.state == 6)
         {
            _nodeOccNTxt.setFrame(_loc2_.camp);
            _nodeOccNTxt.text = _loc2_.nickName + "(" + _loc2_.cdTime + "s)";
         }
         else
         {
            _nodeOccNTxt.text = "";
         }
      }
      
      public function get data() : SecretWarNodeInfo
      {
         return _data;
      }
      
      public function set data(param1:SecretWarNodeInfo) : void
      {
         _data = param1;
         if(_data)
         {
            if(!_isEvent)
            {
               _isEvent = true;
               _data.addEventListener("secretwarNodeTypeEvent",updateViewHandler);
            }
            _mapNode1.bitmapData = SecretwarBitDataUtil.getSmallMap(_data.nodeId);
            _house2.bitmapData = SecretwarBitDataUtil.getHouse(_data.type);
            _nodeBelogTxt.setFrame(_data.camp + 1);
            _nodeBelogTxt.text = LanguageMgr.GetTranslation("secretwar.nodeCamp" + _data.camp);
            switch(int(_data.type) - 3)
            {
               case 0:
               case 1:
                  _nodeStateTxt.setFrame(3);
                  _nodeStateTxt.text = LanguageMgr.GetTranslation("secretwar.noFight");
                  _scoreFt.visible = false;
                  _nodeScoreTxt.visible = false;
                  _stateFt.y = 61;
                  _nodeStateTxt.y = 61;
                  break;
               default:
                  _scoreFt.visible = true;
                  _nodeScoreTxt.visible = true;
            }
         }
      }
      
      private function updateViewHandler(param1:Event) : void
      {
         data = _data;
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         model.selfPlay.addEventListener("secretwarStateEvent",updateViewHandler);
         if(_data)
         {
            _data.addEventListener("secretwarNodeTypeEvent",updateViewHandler);
         }
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         model.selfPlay.removeEventListener("secretwarStateEvent",updateViewHandler);
         if(_data)
         {
            _data.removeEventListener("secretwarNodeTypeEvent",updateViewHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_childView);
         _childView = null;
         super.dispose();
         _data = null;
      }
   }
}

