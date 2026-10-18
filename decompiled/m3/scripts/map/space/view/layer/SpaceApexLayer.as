package map.space.view.layer
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.ApexEvent;
   import flash.display.Sprite;
   import map.space.data.SpaceArmy;
   import map.space.view.physics.SpaceArmyView;
   import mvc.module.apex.ApexModel;
   import mvc.module.apex.ApexPlayerViewData;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ApexManager;
   import yishi.manager.EnterFrameManager;
   
   public class SpaceApexLayer implements IEnterFrame, Disposeable
   {
      
      private var _view1:SpaceArmyView;
      
      private var _view2:SpaceArmyView;
      
      private var _view3:SpaceArmyView;
      
      private var _view4:SpaceArmyView;
      
      private var _container:Sprite;
      
      private var _model:ApexModel = ApexManager.instance.model;
      
      public function SpaceApexLayer(param1:Sprite)
      {
         super();
         _container = param1;
         addEvent();
         init();
      }
      
      private function init() : void
      {
         if(_model.lastWinnerPlayerList)
         {
            refresh();
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         ApexManager.instance.addEventListener("REFRESH_SPACE_AVATAR",__AvatarChangeHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         ApexManager.instance.removeEventListener("REFRESH_SPACE_AVATAR",__AvatarChangeHandler);
      }
      
      private function __AvatarChangeHandler(param1:ApexEvent) : void
      {
         refresh();
      }
      
      public function refresh() : void
      {
         ObjectUtils.disposeObject(_view1);
         _view1 = null;
         ObjectUtils.disposeObject(_view2);
         _view2 = null;
         ObjectUtils.disposeObject(_view3);
         _view3 = null;
         ObjectUtils.disposeObject(_view4);
         _view4 = null;
         _view1 = getUpdateAvatarView(_view1,1,80,4640,2825);
         _view2 = getUpdateAvatarView(_view2,2,80,4820,2880);
         _view3 = getUpdateAvatarView(_view3,3,80,5025,2900);
         _view4 = getUpdateAvatarView(_view4,4,80,5210,2830);
         if(_container && _view1 && !_view1.parent)
         {
            _container.addChild(_view1);
         }
         if(_container && _view2 && !_view2.parent)
         {
            _container.addChild(_view2);
         }
         if(_container && _view3 && !_view3.parent)
         {
            _container.addChild(_view3);
         }
         if(_container && _view4 && !_view4.parent)
         {
            _container.addChild(_view4);
         }
      }
      
      private function getUpdateAvatarView(param1:SpaceArmyView, param2:int, param3:int, param4:int, param5:int) : SpaceArmyView
      {
         var _loc8_:ApexPlayerViewData = null;
         var _loc9_:SpaceArmy = null;
         var _loc6_:AIBaseInfo = null;
         var _loc7_:SpaceArmyView = param1;
         _loc8_ = _model.lastWinnerPlayerList[param2 - 1];
         if(_loc8_ && _loc8_.thaneInfo)
         {
            _loc6_ = new BaseArmyAiInfo();
            _loc9_ = new SpaceArmy();
            _loc9_.nickName = _loc8_.nickName;
            _loc9_.baseHero = _loc8_.thaneInfo;
            _loc9_.baseHero.consortiaName = _loc8_.serverName;
            _loc9_.angle = param3;
            _loc6_.moveState = 3;
            if(!_loc7_)
            {
               _loc7_ = new SpaceArmyView();
               _loc7_.x = param4;
               _loc7_.y = param5;
            }
            _loc7_.info = _loc6_;
            _loc7_.data = _loc9_;
            _loc7_.avatarView.angle = param3;
            _loc7_.setConsortiaName("[" + _loc8_.serverName + "]",2,true);
            _loc7_.mouseEnabled = _loc7_.mouseChildren = false;
         }
         return _loc7_;
      }
      
      public function enterFrame() : void
      {
         if(_view1 && _view1.parent)
         {
            _view1.execute();
         }
         if(_view2 && _view2.parent)
         {
            _view2.execute();
         }
         if(_view3 && _view3.parent)
         {
            _view3.execute();
         }
         if(_view4 && _view4.parent)
         {
            _view4.execute();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view1);
         _view1 = null;
         ObjectUtils.disposeObject(_view2);
         _view2 = null;
         ObjectUtils.disposeObject(_view3);
         _view3 = null;
         ObjectUtils.disposeObject(_view4);
         _view4 = null;
         _container = null;
      }
   }
}

