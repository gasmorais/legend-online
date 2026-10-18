package sqmemory.page
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import mvc.module.children.ChildData;
   import sqmemory.item.SqYinLinAvater;
   import sqmemory.item.SqmemoryItem;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class SqmemoryPage4 extends SqmemoryBasePage
   {
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      private var _childView:SqYinLinAvater;
      
      private var _showWei:SqYinLinAvater;
      
      private var _showContainer:Sprite;
      
      private var _leftT1:FilterFrameText;
      
      public function SqmemoryPage4()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _leftT1 = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page4L1");
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page4.lbox");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.rbox");
         _showContainer = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page4.yilin");
         _childView = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page4.hulin");
         _showWei = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page4.shouwei");
         addChild(_showContainer);
         addChild(_childView);
         addChild(_showWei);
         addChild(_leftVbox);
         addChild(_rightVbox);
         addChild(_leftT1);
         _leftT1.text = LanguageMgr.GetTranslation("sqMemory.note.grow4");
         _showContainer.mouseChildren = _showContainer.mouseEnabled = false;
         _childView.mouseChildren = _childView.mouseEnabled = false;
         _showWei.mouseChildren = _childView.mouseEnabled = false;
      }
      
      private function initData() : void
      {
         var _loc3_:SqmemoryItem = null;
         var _loc8_:String = null;
         var _loc4_:Array = null;
         var _loc1_:String = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:PetTemplate = null;
         var _loc10_:ChildData = null;
         var _loc5_:String = SqMemoryManger.Instance.userDataInfo.growthInfo;
         var _loc6_:Array = _loc5_.split("|");
         _leftVbox.beginChanges();
         _loc7_ = 3;
         while(_loc7_ <= 5)
         {
            _loc8_ = _loc6_[_loc7_];
            _loc3_ = createNote(_loc8_,["sqMemory.note.grow4_Y_" + (_loc7_ - 2),"sqMemory.note.grow4_N_" + (_loc7_ - 2)],[3,3]);
            if(_loc3_)
            {
               _leftVbox.addChild(_loc3_);
            }
            _loc7_++;
         }
         _leftVbox.commitChanges();
         _rightVbox.beginChanges();
         _loc3_ = new SqmemoryItem(2);
         _loc1_ = LanguageMgr.GetTranslation("sqMemory.note.grow5");
         _loc3_.updateView(_loc1_);
         _rightVbox.addChild(_loc3_);
         _loc7_ = 6;
         while(_loc7_ <= 8)
         {
            _loc8_ = _loc6_[_loc7_];
            _loc3_ = createNote(_loc8_,["sqMemory.note.grow5_Y_" + (_loc7_ - 5),"sqMemory.note.grow5_N_" + (_loc7_ - 5)],[3,3]);
            if(_loc3_)
            {
               _loc3_.x = 10;
               _rightVbox.addChild(_loc3_);
            }
            _loc7_++;
         }
         _rightVbox.commitChanges();
         _loc8_ = _loc6_[6];
         if(_loc8_ != "#")
         {
            _loc4_ = _loc8_.split(",");
            _loc9_ = int(_loc4_[2]);
            _loc2_ = TempleteManager.instance.petTemplateCate.getTemplateById(_loc9_);
            if(_loc2_)
            {
               startLoader(_loc2_.PetAvatar);
            }
         }
         _loc8_ = _loc6_[7];
         if(_loc8_ != "#")
         {
            _loc4_ = _loc8_.split(",");
            _loc10_ = new ChildData();
            _loc10_.job = int(_loc4_[2]);
            _loc10_.growthGrade = int(_loc4_[3]);
            _loc10_.state = 1;
            _childView.data = _loc10_;
         }
         _loc8_ = _loc6_[8];
         if(_loc8_ != "#")
         {
            _loc4_ = _loc8_.split(",");
            _loc10_ = new ChildData();
            _loc10_.job = int(_loc4_[2]);
            _loc10_.growthGrade = int(_loc4_[3]);
            _loc10_.state = 1;
            _showWei.data = _loc10_;
         }
      }
      
      private function startLoader(param1:String) : void
      {
         var _loc2_:String = PathManager.getPetMorphShowPath(param1);
         LoaderManagerII.instance.load(_loc2_,2,8,__loadMorphAvatarCompleteHandler);
      }
      
      private function __loadMorphAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadMorphAvatarCompleteHandler);
         var _loc3_:MovieClip = param2 as MovieClip;
         if(_loc3_)
         {
            if(_loc3_["pos_down"])
            {
               _loc3_.x = -_loc3_["pos_down"]["x"];
               _loc3_.y = -_loc3_["pos_down"]["y"];
            }
            _showContainer.addChild(_loc3_);
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadMorphAvatarCompleteHandler);
         ObjectUtils.disposeAllChildren(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_showWei);
         _showWei = null;
         ObjectUtils.disposeObject(_childView);
         _childView = null;
         ObjectUtils.disposeAllChildren(_leftVbox);
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         ObjectUtils.disposeAllChildren(_rightVbox);
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         ObjectUtils.disposeObject(_leftT1);
         _leftT1 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

