package farm.newview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import farm.view.FarmAnimalLayer;
   import farm.view.marrytree.MarryTreeView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.view.community.MagicSpringBufferAddView;
   
   public class PastureView extends Component
   {
      
      private var _marryTree:MarryTreeView;
      
      private var _farmAnimalLayer:FarmAnimalLayer;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _railingImage:Bitmap;
      
      private var _animalBoardImage:Image;
      
      private var _animalUpNameBg:MutipleImage;
      
      private var _animalUpNameTxt:FilterFrameText;
      
      private var _animalUpLevelTxt:FilterFrameText;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _data:FarmInfo;
      
      public function PastureView()
      {
         super();
         initView();
         initBufferView();
         addEvent();
      }
      
      private function initView() : void
      {
         _railingImage = ComponentFactory.Instance.creatBitmap("asset.PastureView.railingImage");
         _farmAnimalLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmAnimalLayer");
         _marryTree = ComponentFactory.Instance.creatCustomObject("PastureView.marryTree");
         _animalBoardImage = ComponentFactory.Instance.creatComponentByStylename("PastureView.animalBoardImage");
         _animalUpNameBg = ComponentFactory.Instance.creatComponentByStylename("PastureView.animalUpNameBg");
         _animalUpNameTxt = ComponentFactory.Instance.creatComponentByStylename("PastureView.animalUpNameTxt");
         _animalUpLevelTxt = ComponentFactory.Instance.creatComponentByStylename("PastureView.animalUpLevelTxt");
         addChild(_marryTree);
         initTreeView();
         addChild(_farmAnimalLayer);
         addChild(_railingImage);
         addChild(_animalBoardImage);
         addChild(_animalUpNameBg);
         addChild(_animalUpNameTxt);
         addChild(_animalUpLevelTxt);
         _animalUpNameTxt.text = LanguageMgr.GetTranslation("farm.anima.animalName");
         _buildingFilter = new SimpleBuildingFilter();
      }
      
      private function initBufferView() : void
      {
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(2);
         if(_loc2_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc2_);
            _bufferView.stopTimer();
            _loc1_ = LanguageMgr.GetTranslation("home.pastureView.bufferText",_loc2_.tempInfo.AddValue);
            _bufferView.setDescText(_loc1_);
            _bufferView.x = 20;
            _bufferView.y = 80;
            addChild(_bufferView);
         }
      }
      
      private function initTreeView() : void
      {
         _marryTree.info = null;
         if(_marryTree.feedBtn)
         {
            addChild(_marryTree.lang);
         }
         if(_marryTree.feedBtn)
         {
            addChild(_marryTree.feedBtn);
            _marryTree.feedBtn.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _animalBoardImage.addEventListener("rollOver",__onBuildingOver);
         _animalBoardImage.addEventListener("rollOut",__onBuildingOut);
      }
      
      private function removeEvent() : void
      {
         _animalBoardImage.removeEventListener("rollOver",__onBuildingOver);
         _animalBoardImage.removeEventListener("rollOut",__onBuildingOut);
         if(_data)
         {
            _data.removeEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
            _data.removeEventListener("LAND_OPEN",__farmInfoUpdateHandler);
         }
      }
      
      public function set data(param1:FarmInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         if(_data)
         {
            _data.removeEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
            _data.removeEventListener("LAND_OPEN",__farmInfoUpdateHandler);
         }
         _data = param1;
         if(_data)
         {
            _data.addEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
            _data.addEventListener("LAND_OPEN",__farmInfoUpdateHandler);
         }
         refreshView();
      }
      
      private function __farmInfoUpdateHandler(param1:FarmEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.grade >= 5)
         {
            _animalBoardImage.tipData = LanguageMgr.GetTranslation("farm.anima.animalContentTips",_data.animalCount,_data.animalPosCount);
            _animalUpLevelTxt.text = _data.animalCount + "/" + _data.animalPosCount;
         }
         else
         {
            _animalBoardImage.tipData = LanguageMgr.GetTranslation("farm.anima.animalContentTips","-","-");
            _animalUpLevelTxt.text = "-/-";
         }
         if(_bufferView && _bufferView.parent)
         {
            if(_data.userId == ArmyManager.instance.thane.userId)
            {
               _bufferView.resetTimer();
               _bufferView.visible = true;
            }
            else
            {
               _bufferView.stopTimer();
               _bufferView.visible = false;
            }
         }
      }
      
      private function __onBuildingOver(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(param1.currentTarget as DisplayObject);
      }
      
      private function __onBuildingOut(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(param1.currentTarget as DisplayObject);
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_farmAnimalLayer)
         {
            ObjectUtils.disposeObject(_farmAnimalLayer);
         }
         _farmAnimalLayer = null;
         if(_marryTree)
         {
            ObjectUtils.disposeObject(_marryTree);
         }
         _marryTree = null;
         if(_animalBoardImage)
         {
            ObjectUtils.disposeObject(_animalBoardImage);
         }
         _animalBoardImage = null;
         if(_animalUpNameBg)
         {
            ObjectUtils.disposeObject(_animalUpNameBg);
         }
         _animalUpNameBg = null;
         if(_animalUpNameTxt)
         {
            ObjectUtils.disposeObject(_animalUpNameTxt);
         }
         _animalUpNameTxt = null;
         if(_animalUpLevelTxt)
         {
            ObjectUtils.disposeObject(_animalUpLevelTxt);
         }
         _animalUpLevelTxt = null;
         if(_railingImage)
         {
            ObjectUtils.disposeObject(_railingImage);
         }
         _railingImage = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         _buildingFilter = null;
         super.dispose();
      }
   }
}

