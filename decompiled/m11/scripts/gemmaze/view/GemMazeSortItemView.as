package gemmaze.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.gemmaze.GemMazeOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.PlayerMenu;
   
   public class GemMazeSortItemView extends SelectedButton implements IListCell
   {
      
      private var _line:Bitmap;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _orderTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipnameTxt:GradientText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _appellTxt:GradientText;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _data:GemMazeOrderInfo;
      
      public function GemMazeSortItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemBg");
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextValueStyle1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextValueStyle2");
         _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextStyle2_vip");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextValueStyle3");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextValueStyle4");
         _appellTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.sort.ItemTextValueStyle5");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _line = ComponentFactory.Instance.creatBitmap("asset.GemMazeSort.line");
         addChild(_itemBg);
         addChild(_orderTxt);
         addChild(_levelTxt);
         addChild(_scoreTxt);
         addChild(_appellTxt);
         addChild(_line);
         _itemBg.setFrame(1);
         _vipnameTxt.x = _nameTxt.x;
         _vipnameTxt.y = _nameTxt.y;
         _vipnameTxt.width = _nameTxt.width;
      }
      
      override protected function addEvent() : void
      {
         addEventListener("click",__onItemClick);
         addEventListener("rollOver",__onItemOver);
         addEventListener("rollOut",__onItemOut);
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("click",__onItemClick);
         removeEventListener("rollOver",__onItemOver);
         removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.userId = _data.userId;
         _loc2_.job = _data.job;
         _loc2_.nickName = _data.nickName;
         _loc2_.consortiaName = _data.consortiaName;
         _loc2_.grades = _data.grades;
         _loc2_.fightingCapacity = _data.fightingCapacity;
         var _loc3_:PlayerMenu = new PlayerMenu();
         _loc3_.setData(_loc2_);
         _loc3_.x = StageReferance.stage.mouseX;
         _loc3_.y = StageReferance.stage.mouseY;
         LayerManager.Instance.addToLayer(_loc3_,7);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _itemBg.setFrame(2);
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _itemBg.setFrame(1);
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(_data)
         {
            _data.selected = param1;
            selectedEffect(param1);
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_appellTxt);
         _appellTxt = null;
         ObjectUtils.disposeObject(_vipnameTxt);
         _vipnameTxt = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function selectedEffect(param1:Boolean) : void
      {
         if(param1)
         {
            _itemBg.setFrame(2);
         }
         else
         {
            _itemBg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         data = param1 as GemMazeOrderInfo;
      }
      
      public function set data(param1:GemMazeOrderInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         selectedEffect(_data.selected);
         _nameTxt.parent && _nameTxt.parent.removeChild(_nameTxt);
         _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
         _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
         _vipnameTxt.text = _data.nickName;
         _nameTxt.text = _data.nickName;
         _vipIcon.x = 100;
         _vipIcon.y = _vipnameTxt.y + 2;
         if(_data.isVip)
         {
            _data.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
            addChild(_vipnameTxt);
            addChild(_vipIcon);
         }
         else
         {
            addChild(_nameTxt);
         }
         _orderTxt.text = String(_data.order);
         _levelTxt.text = _data.gemMazeGrades + "";
         _scoreTxt.text = _data.score + "";
         if(_data.order == 1)
         {
            _appellTxt.text = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(103).Title;
         }
         else if(_data.order == 2)
         {
            _appellTxt.text = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(104).Title;
         }
         else if(_data.order == 3)
         {
            _appellTxt.text = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(105).Title;
         }
         else
         {
            _appellTxt.text = "";
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

