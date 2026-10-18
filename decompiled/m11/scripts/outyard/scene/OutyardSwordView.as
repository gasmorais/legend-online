package outyard.scene
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.outyard.LandPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardSwordView extends Component
   {
      
      private var _mapId:int;
      
      private var _swordDic:Dictionary;
      
      private var _headDic:Dictionary;
      
      private var _joinDic:Dictionary;
      
      private var _occupyDic:Dictionary;
      
      private var _crystalMc:MovieClip;
      
      public function OutyardSwordView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:ScaleFrameImage = null;
         var _loc2_:Bitmap = null;
         var _loc6_:FilterFrameText = null;
         var _loc3_:ScaleFrameImage = null;
         _swordDic = new Dictionary();
         _headDic = new Dictionary();
         _joinDic = new Dictionary();
         _occupyDic = new Dictionary();
         var _loc1_:Dictionary = OutyardManager.instance.model.nodeDic;
         for each(var _loc5_:LandPoint in _loc1_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("outyard.routeLandSword");
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.outyard.headSoldierBmp");
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("outyard.LandNodeView.JoinTxt");
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoImage3");
            _loc4_.x = _loc5_.posX - 22;
            _loc4_.y = _loc5_.posY - 10;
            _loc2_.x = _loc5_.posX - 35;
            _loc2_.y = _loc5_.posY - 45;
            _loc6_.x = _loc5_.posX - 22;
            _loc6_.y = _loc5_.posY - 42;
            _loc3_.x = _loc5_.posX - 10;
            _loc3_.y = _loc5_.posY + 8;
            this.addChild(_loc4_);
            this.addChild(_loc2_);
            this.addChild(_loc6_);
            this.addChild(_loc3_);
            _swordDic[_loc5_.id] = _loc4_;
            _headDic[_loc5_.id] = _loc2_;
            _joinDic[_loc5_.id] = _loc6_;
            _occupyDic[_loc5_.id] = _loc3_;
         }
         _crystalMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.crystalMovie");
         _crystalMc.x = 1465;
         _crystalMc.y = 755;
         _crystalMc.visible = false;
         this.addChild(_crystalMc);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
      }
      
      private function __updateNodeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ScaleFrameImage = null;
         var _loc5_:Bitmap = null;
         var _loc7_:FilterFrameText = null;
         var _loc4_:ScaleFrameImage = null;
         var _loc2_:Dictionary = OutyardManager.instance.model.nodeDic;
         for each(var _loc6_:LandPoint in _loc2_)
         {
            _loc3_ = _swordDic[_loc6_.id];
            _loc5_ = _headDic[_loc6_.id];
            _loc7_ = _joinDic[_loc6_.id];
            _loc4_ = _occupyDic[_loc6_.id];
            _loc3_.visible = false;
            _loc5_.visible = false;
            _loc7_.visible = false;
            _loc4_.visible = false;
            if(_loc6_.mapId == _mapId)
            {
               if(_loc6_.nodeType != 1)
               {
                  if(_loc6_.nodeType == 2)
                  {
                     if(_loc6_.nodeState != 0)
                     {
                        if(_loc6_.nodeState == 2)
                        {
                           _loc3_.visible = true;
                           if(_loc6_.attackCount + _loc6_.defenceCount > 0)
                           {
                              _loc5_.visible = true;
                              _loc7_.visible = true;
                              _loc7_.text = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.joinTxt",_loc6_.attackCount + _loc6_.defenceCount);
                           }
                           _loc3_.setFrame(2);
                        }
                        else if(_loc6_.nodeState == 3)
                        {
                           _loc3_.visible = true;
                           if(_loc6_.attackCount + _loc6_.defenceCount > 0)
                           {
                              _loc5_.visible = true;
                              _loc7_.visible = true;
                              _loc7_.text = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.joinTxt",_loc6_.attackCount + _loc6_.defenceCount);
                           }
                           _loc3_.setFrame(1);
                        }
                     }
                  }
                  else if(_loc6_.nodeType != 4)
                  {
                     if(_loc6_.nodeType == 3)
                     {
                        if(_loc6_.forceIndex != 0)
                        {
                           _loc4_.visible = true;
                           _loc4_.setFrame(_loc6_.forceIndex);
                        }
                        _crystalMc.visible = OutyardManager.instance.model.stateMsg.stackHeadState == 3;
                     }
                  }
               }
            }
         }
      }
      
      public function setMapId(param1:int) : void
      {
         _mapId = param1;
         __updateNodeHandler(null);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for(var _loc1_:String in _swordDic)
         {
            ObjectUtils.disposeObject(_swordDic[_loc1_]);
            _swordDic[_loc1_] = null;
            delete _swordDic[_loc1_];
         }
         for(_loc1_ in _headDic)
         {
            ObjectUtils.disposeObject(_headDic[_loc1_]);
            _headDic[_loc1_] = null;
            delete _headDic[_loc1_];
         }
         for(_loc1_ in _joinDic)
         {
            ObjectUtils.disposeObject(_joinDic[_loc1_]);
            _joinDic[_loc1_] = null;
            delete _joinDic[_loc1_];
         }
         for(_loc1_ in _occupyDic)
         {
            ObjectUtils.disposeObject(_occupyDic[_loc1_]);
            _occupyDic[_loc1_] = null;
            delete _occupyDic[_loc1_];
         }
         ObjectUtils.disposeViolentMc(_crystalMc);
         _crystalMc = null;
         super.dispose();
      }
   }
}

