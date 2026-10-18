package child.attribute
{
   import avatar.load.ShowAvatarLoader;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.children.ChildData;
   import yishi.manager.PathManager;
   
   public class ChildShowAvatar extends Sprite implements Disposeable
   {
      
      private var _layer1:ShowAvatarLoader;
      
      private var _layer2:ShowAvatarLoader;
      
      private var _layer3:ShowAvatarLoader;
      
      private var _path1:String;
      
      private var _path2:String;
      
      private var _path3:String;
      
      private var _data:ChildData;
      
      public function ChildShowAvatar()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         initView();
      }
      
      private function initView() : void
      {
         _layer1 = new ShowAvatarLoader(loadComplete);
         _layer2 = new ShowAvatarLoader(loadComplete);
         _layer3 = new ShowAvatarLoader(loadComplete);
         addChild(_layer1);
         addChild(_layer2);
         addChild(_layer3);
      }
      
      private function loadComplete() : void
      {
         _layer1.gotoAndPlay(1);
         _layer2.gotoAndPlay(1);
         _layer3.gotoAndPlay(1);
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         _path1 = "";
         _path2 = "";
         _path3 = "";
         if(_data)
         {
            refreshPath();
         }
         _layer1.initPath(_path1);
         _layer2.initPath(_path2);
         _layer3.initPath(_path3);
      }
      
      private function refreshPath() : void
      {
         if(_data.state == 1)
         {
            _path2 = PathManager.getChildShowByJobAndGrade(_data.job,_data.growthGrade);
            _path1 = "";
            _path3 = "";
         }
      }
      
      public function dispose() : void
      {
         _data = null;
         if(_layer1)
         {
            _layer1.dispose();
         }
         _layer1 = null;
         if(_layer2)
         {
            _layer2.dispose();
         }
         _layer2 = null;
         if(_layer3)
         {
            _layer3.dispose();
         }
         _layer3 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

