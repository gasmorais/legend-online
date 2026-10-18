package pet.common
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.PathManager;
   
   public class PetAvatarView extends Component
   {
      
      private var _url:String;
      
      private var _isLoading:Boolean;
      
      private var _data:PetTemplate;
      
      public function PetAvatarView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get data() : PetTemplate
      {
         return _data;
      }
      
      public function set data(param1:PetTemplate) : void
      {
         _data = param1;
         var _loc2_:String = null;
         if(param1)
         {
            _loc2_ = PathManager.getPetMorphShowPath(param1.PetAvatar);
         }
         if(_loc2_ == _url)
         {
            return;
         }
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
            _isLoading = false;
         }
         ObjectUtils.disposeAllChildren(this);
         _url = _loc2_;
         if(_url)
         {
            _isLoading = true;
            LoaderManagerII.instance.load(_url,2,8,__loadedCompleteHandler);
         }
      }
      
      private function __loadedCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Number = NaN;
         _isLoading = false;
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            if(_loc4_["pos_down"])
            {
               _loc4_.x = -_loc4_["pos_down"]["x"];
               _loc4_.y = -_loc4_["pos_down"]["y"];
            }
            _loc5_ = _loc4_.height;
            if(_loc4_["pos_up"] && _loc4_["pos_down"])
            {
               _loc5_ = Math.abs(_loc4_["pos_up"]["y"] - _loc4_["pos_down"]["y"]);
            }
            _loc3_ = 190 / _loc5_;
            this.scaleX = _loc3_;
            this.scaleY = _loc3_;
            addChild(_loc4_);
            _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         }
      }
      
      override public function dispose() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         }
         _url = null;
         _data = null;
         super.dispose();
      }
   }
}

