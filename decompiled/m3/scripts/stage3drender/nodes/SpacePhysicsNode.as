package stage3drender.nodes
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import events.RingTaskEvent;
   import flash.display.DisplayObject;
   import managers.RingTaskManager;
   import map.internals.data.SpaceNode;
   import map.internals.view.hero.NpcNameView;
   import mvc.module.ringtask.RingTask;
   import stage3drender.Global;
   import starling.core.Starling;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.PathManager;
   
   public class SpacePhysicsNode extends MapNodeRender
   {
      
      private var _movie:Stage3dMoviel;
      
      private var _nameView:NpcNameView;
      
      public function SpacePhysicsNode()
      {
         super();
         initEvent();
      }
      
      override protected function initContainer() : void
      {
         _movie = new Stage3dMoviel();
         _movieContainer.addChild(_movie);
         Starling.juggler.add(_movie);
      }
      
      override protected function get resourcesPath() : String
      {
         return PathManager.solveMapPhysicsBySonType((_info as SpaceNode).sonType);
      }
      
      override protected function setSwf() : void
      {
         var _loc1_:String = resourcesPath;
         if(_loc1_ == _url)
         {
            return;
         }
         _url = _loc1_;
         if(Global.avatarTextureDic[_url])
         {
            _movie.setFrameTextures(Global.avatarTextureDic[_url],_url);
         }
         else
         {
            LoaderManagerII.instance.load(_loc1_,2,5,addNetMovieClip);
         }
      }
      
      override protected function addNetMovieClip(param1:LoaderInfo, param2:Object) : void
      {
         if(_isDispose)
         {
            return;
         }
         if(!param2)
         {
            return;
         }
         _movie.setContent(param2 as DisplayObject,_url);
      }
      
      public function get movie() : Stage3dMoviel
      {
         return _movie;
      }
      
      override protected function initView() : void
      {
         super.initView();
         __refreshView(null);
      }
      
      private function initEvent() : void
      {
         RingTaskManager.instance.addEventListener("REFRESHTING",__refreshView);
      }
      
      private function removeEvent() : void
      {
         RingTaskManager.instance.removeEventListener("REFRESHTING",__refreshView);
      }
      
      private function __refreshView(param1:RingTaskEvent) : void
      {
         setMouseEnable();
         if((info as SpaceNode).nodeId == 18)
         {
            if(touchable == true)
            {
               if(!_nameView)
               {
                  _nameView = new NpcNameView();
               }
               _nameView.nodeInfo = this._info;
               _nameView.x = this.x;
               _nameView.y = this.y;
               _nameView.npcName.x = -76;
               _nameView.npcName.y = -92;
               Global.nameLayer.addChildAt(_nameView,0);
            }
            else if(_nameView)
            {
               _nameView.dispose();
               _nameView = null;
            }
         }
      }
      
      private function setMouseEnable() : void
      {
         var _loc2_:RingTask = null;
         var _loc1_:OfferRewardConditionTemplate = null;
         if((info as SpaceNode).nodeId == 18)
         {
            _loc2_ = RingTaskManager.instance.getRingTask();
            if(!_loc2_)
            {
               touchable = false;
               return;
            }
            _loc1_ = _loc2_.conditionList[0] as OfferRewardConditionTemplate;
            if(_loc1_.CondictionType != 4)
            {
               touchable = false;
               return;
            }
            if(_loc1_.Para1 + "" != (info as SpaceNode).param4)
            {
               touchable = false;
               return;
            }
            if(_loc2_.isCompleted)
            {
               touchable = false;
               return;
            }
         }
         touchable = true;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_nameView)
         {
            _nameView.dispose();
            _nameView = null;
         }
         if(_movie)
         {
            _movie.removeFromParent();
         }
         super.dispose();
      }
      
      public function get nameView() : NpcNameView
      {
         return _nameView;
      }
   }
}

