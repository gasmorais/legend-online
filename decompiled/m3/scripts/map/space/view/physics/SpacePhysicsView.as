package map.space.view.physics
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import events.RingTaskEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import managers.RingTaskManager;
   import map.internals.data.MapPhysics;
   import map.internals.data.SpaceNode;
   import map.internals.data.template.MapTemplate;
   import map.internals.view.physics.MapPhysicsAttackingBase;
   import map.space.SpaceManager;
   import map.space.data.SpaceNodeType;
   import mvc.module.ringtask.RingTask;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class SpacePhysicsView extends MapPhysicsAttackingBase
   {
      
      public static const NAME:String = "map.space.view.physics.SpacePhysicsView";
      
      private var _mediatorKey:String;
      
      private var _buildName:FilterFrameText;
      
      private var _nameBg:ScaleLeftRightImage;
      
      private var _buildNameBitmap:Bitmap;
      
      private var _hitBitmap:Bitmap;
      
      private var _resUrl:String;
      
      public function SpacePhysicsView()
      {
         super(1);
         buttonMode = true;
      }
      
      override protected function initView() : void
      {
         var _loc1_:MapTemplate = null;
         super.initView();
         initEvent();
         if(_nameBg == null)
         {
            _nameBg = ComponentFactory.Instance.creatComponentByStylename("map.style.BuildNameBg");
         }
         if(_buildName == null)
         {
            _buildName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         }
         if(_buildNameBitmap == null)
         {
            _buildNameBitmap = ComponentFactory.Instance.creatBitmap("asset.map.OfferRewardBuildName");
         }
         if(info.info.names != "")
         {
            _buildName.text = info.info.names;
         }
         if((info as SpaceNode).moveToMapId != 0)
         {
            _loc1_ = TempleteManager.instance.mapTemplateCate.getTemplateByID((info as SpaceNode).moveToMapId);
            _buildName.text = _loc1_.MapName;
         }
         _buildName.x = -_buildName.width / 2;
         _buildName.mouseEnabled = false;
         if((info as SpaceNode).nodeId == 18)
         {
            _buildName.x = -76;
            _buildName.y = -92;
            addChild(_buildName);
            _buildName.setFrame(4);
         }
         setMouseEnable(null);
      }
      
      private function initEvent() : void
      {
         if(RingTaskManager.instance.hasEventListener("REFRESHTING") == false)
         {
            RingTaskManager.instance.addEventListener("REFRESHTING",setMouseEnable);
         }
      }
      
      private function removeEvent() : void
      {
         RingTaskManager.instance.removeEventListener("REFRESHTING",setMouseEnable);
      }
      
      private function initMediator() : void
      {
         if(!info || !info.info)
         {
            return;
         }
         var _loc1_:Array = [];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.physics.SpacePhysicsView");
      }
      
      override public function set info(param1:MapPhysics) : void
      {
         super.info = param1;
         initMediator();
      }
      
      override protected function layouCallBack() : void
      {
         var _loc5_:Sprite = null;
         var _loc4_:BitmapData = null;
         var _loc1_:Rectangle = null;
         var _loc6_:Matrix = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc7_:Point = null;
         if(isCollection)
         {
            if(getMovie)
            {
               _loc1_ = getMovie.getBounds(getMovie);
               _loc4_ = new BitmapData(_loc1_.width + 10,_loc1_.height,true,0);
               _loc6_ = new Matrix();
               _loc6_.translate(-_loc1_.x,-_loc1_.y);
               _loc4_.draw(getMovie,_loc6_);
               _hitBitmap = new Bitmap(_loc4_);
               _hitBitmap.x = _loc1_.x;
               _hitBitmap.y = _loc1_.y;
               _hitBitmap.visible = false;
               addChild(_hitBitmap);
               _loc5_ = DisplayUtils.getHitArea(_loc4_,5);
               _loc5_.x = _loc1_.x;
               _loc5_.y = _loc1_.y;
               hitArea = _loc5_;
               movie.addChild(_loc5_);
            }
            if(SpaceNodeType.isYearNode(info.info.types))
            {
               if((info as SpaceNode).stateId == 1)
               {
                  _buildName.y = -92;
                  addChild(_buildName);
                  _buildName.setFrame(4);
                  _buildName.text = info.info.names;
               }
               else if(_buildName && _buildName.parent)
               {
                  _buildName.parent.removeChild(_buildName);
               }
               buttonMode = false;
               mouseEnabled = mouseChildren = (info as SpaceNode).stateId == 1;
            }
         }
         if((isOfferReward || isAntaeus) && hasEffectArea)
         {
            _loc2_ = new Point(effectArea.x,effectArea.y);
            _loc3_ = effectArea.parent.localToGlobal(_loc2_);
            _loc7_ = _loc3_;
            if(StageReferance.stage.contains(this))
            {
               _loc7_ = globalToLocal(_loc3_);
            }
            _loc4_ = new BitmapData(effectArea.width,effectArea.height,true,0);
            _loc4_.draw(effectArea);
            _hitBitmap = new Bitmap(_loc4_);
            _hitBitmap.x = _loc7_.x;
            _hitBitmap.y = _loc7_.y;
            _hitBitmap.visible = false;
            addChild(_hitBitmap);
            _loc5_ = DisplayUtils.getHitArea(_loc4_,5);
            _loc5_.x = _loc7_.x;
            _loc5_.y = _loc7_.y;
            hitArea = _loc5_;
            movie.addChild(_loc5_);
         }
      }
      
      override protected function get resourcesPath() : String
      {
         if(SpaceNodeType.isYearNode(info.info.types) && (info as SpaceNode).stateId == 0)
         {
            return "";
         }
         _resUrl = PathManager.solveMapPhysicsBySonType((info as SpaceNode).sonType);
         return _resUrl;
      }
      
      public function get resUrl() : String
      {
         return this._resUrl;
      }
      
      override public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(hasEffectArea)
         {
            SpaceManager.instance.model.glowTarget = this;
         }
         if(isTransfer)
         {
            if(getMovie)
            {
               filter.setLightFilter(getMovie);
            }
            SpaceManager.instance.model.glowTarget = this;
         }
         if(isOfferReward)
         {
            SpaceManager.instance.model.glowTarget = this;
         }
         return true;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(isTransfer)
         {
            if(getMovie)
            {
               filter.setNormalFilter(getMovie);
            }
         }
         return true;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(hasEffectArea)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return attackFun();
            }
         }
         else if(isTransfer)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return attackFun();
            }
         }
         else if(isOfferReward)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return attackFun();
            }
         }
         else if(isAntaeus)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return attackFun();
            }
         }
         return false;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(hasEffectArea)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               SpaceManager.instance.model.glowTarget = this;
               return true;
            }
         }
         else if(isCollection)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY) && (info as SpaceNode).stateId == 1)
            {
               return true;
            }
         }
         else if(isOfferReward)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return true;
            }
         }
         else if(isAntaeus)
         {
            if(_hitBitmap && _hitBitmap.bitmapData.getPixel(_hitBitmap.mouseX,_hitBitmap.mouseY))
            {
               return true;
            }
         }
         return false;
      }
      
      public function setGlowFilter() : void
      {
         if(hasEffectArea)
         {
            filter.setGlowFilter(effectArea);
         }
      }
      
      public function setNormalFilter() : void
      {
         if(hasEffectArea)
         {
            filter.setNormalFilter(effectArea);
         }
      }
      
      private function get effectArea() : Sprite
      {
         if(hasEffectArea)
         {
            return getMovie["content"]["effect_area"];
         }
         return getMovie;
      }
      
      private function get hasEffectArea() : Boolean
      {
         if(getMovie)
         {
            if(getMovie.hasOwnProperty("content") && getMovie["content"])
            {
               if(getMovie["content"].hasOwnProperty("effect_area") && getMovie["content"]["effect_area"])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get isOfferReward() : Boolean
      {
         if((info as SpaceNode).nodeId == 1)
         {
            return true;
         }
         if((info as SpaceNode).nodeId == 35 || (info as SpaceNode).nodeId == 36)
         {
            return true;
         }
         return false;
      }
      
      private function get isTransfer() : Boolean
      {
         if((info as SpaceNode).param1 == 2 || (info as SpaceNode).nodeId == 18 || (info as SpaceNode).info.types == 40 || SpaceNodeType.isYearNode(info.info.types) && (info as SpaceNode).stateId == 1)
         {
            return true;
         }
         return false;
      }
      
      private function get isAntaeus() : Boolean
      {
         if((info as SpaceNode).nodeId == 47)
         {
            return true;
         }
         return false;
      }
      
      private function get isCollection() : Boolean
      {
         if((info as SpaceNode).nodeId == 18)
         {
            return true;
         }
         if(SpaceNodeType.isYearNode((info as SpaceNode).info.types))
         {
            return true;
         }
         return false;
      }
      
      public function attackFun() : Boolean
      {
         if(!SpaceManager.instance.model.mapTielsData)
         {
            return false;
         }
         SpaceManager.instance.visitSpaceNPC((info as SpaceNode).nodeId,true);
         return true;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1 && !isTransfer)
         {
            if(!_nameBg)
            {
            }
            if(!_buildName)
            {
            }
            if(!_buildNameBitmap)
            {
            }
         }
         else
         {
            if(_nameBg && _nameBg.parent)
            {
               _nameBg.parent.removeChild(_nameBg);
            }
            if(_buildName)
            {
               if((info as SpaceNode).nodeId != 18)
               {
                  if(_buildName.parent)
                  {
                     _buildName.parent.removeChild(_buildName);
                  }
               }
               if(SpaceNodeType.isYearNode(info.info.types))
               {
                  if((info as SpaceNode).stateId != 1)
                  {
                     if(_buildName.parent)
                     {
                        _buildName.parent.removeChild(_buildName);
                     }
                     if(_movie)
                     {
                        ObjectUtils.disposeViolentMc(_movie);
                     }
                     _movie = null;
                  }
                  else
                  {
                     addChild(_buildName);
                  }
               }
            }
            if(_buildNameBitmap && _buildNameBitmap.parent)
            {
               _buildNameBitmap.parent.removeChild(_buildNameBitmap);
            }
         }
      }
      
      private function setMouseEnable(param1:RingTaskEvent) : void
      {
         var _loc3_:RingTask = null;
         var _loc2_:OfferRewardConditionTemplate = null;
         if((info as SpaceNode).nodeId == 18)
         {
            _loc3_ = RingTaskManager.instance.getRingTask();
            if(!_loc3_)
            {
               _buildName.visible = false;
               mouseEnabled = false;
               return;
            }
            _loc2_ = _loc3_.conditionList[0] as OfferRewardConditionTemplate;
            if(_loc2_.CondictionType != 4)
            {
               _buildName.visible = false;
               mouseEnabled = false;
               return;
            }
            if(_loc2_.Para1 + "" != (info as SpaceNode).param4)
            {
               _buildName.visible = false;
               mouseEnabled = false;
               return;
            }
            if(_loc3_.isCompleted)
            {
               _buildName.visible = false;
               mouseEnabled = false;
               return;
            }
         }
         _buildName.visible = true;
         mouseEnabled = true;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_nameBg);
         _nameBg = null;
         ObjectUtils.disposeObject(_buildName);
         _buildName = null;
         ObjectUtils.disposeObject(_buildNameBitmap);
         _buildNameBitmap = null;
         ObjectUtils.disposeObject(_hitBitmap);
         _hitBitmap = null;
         tipData = null;
         _resUrl = null;
         super.dispose();
      }
   }
}

