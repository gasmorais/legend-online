package map.campaign.pvp.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.sort.SortData;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class PvpHeroItemView extends SelectedButton implements IListCell
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _data:SortData;
      
      private var _para0:FilterFrameText;
      
      private var _para1:FilterFrameText;
      
      private var _para2:FilterFrameText;
      
      private var _para3:FilterFrameText;
      
      public function PvpHeroItemView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("PvpHeroFrame.itemBg");
         _bg.setFrame(1);
         _para0 = ComponentFactory.Instance.creatComponentByStylename("PvpHeroItemView.Txt00");
         _para1 = ComponentFactory.Instance.creatComponentByStylename("PvpHeroItemView.Txt01");
         _para2 = ComponentFactory.Instance.creatComponentByStylename("PvpHeroItemView.Txt02");
         _para3 = ComponentFactory.Instance.creatComponentByStylename("PvpHeroItemView.Txt03");
         addChild(_bg);
         addChild(_para0);
         addChild(_para1);
         addChild(_para2);
         addChild(_para3);
      }
      
      override protected function addEvent() : void
      {
         addEventListener("rollOver",__onMouseOver);
         addEventListener("rollOut",__onMouseOut);
         addEventListener("click",__onClickHandler);
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseOver);
         removeEventListener("rollOut",__onMouseOut);
         removeEventListener("click",__onClickHandler);
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _bg.setFrame(2);
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _bg.setFrame(1);
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _bg.setFrame(2);
         var _loc4_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         var _loc2_:Boolean = _loc4_ != _data.serverName;
         var _loc3_:PlayerMenu = new PlayerMenu(false,false,_loc2_);
         _loc3_.setData(_data);
         _loc3_.x = StageReferance.stage.mouseX;
         _loc3_.y = StageReferance.stage.mouseY;
         LayerManager.Instance.addToLayer(_loc3_,7);
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _selected = param2;
         if(param2)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as SortData;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _para0.text = _data.nikcName;
            _para1.text = _data.serverName == null ? "" : _data.serverName;
            _para2.text = _data.pvpScore.toString();
            _para3.text = _data.army.baseHero.honerTemp.TemplateName;
         }
         else
         {
            _para0.text = "";
            _para1.text = "";
            _para2.text = "";
            _para3.text = "";
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_para0);
         _para0 = null;
         ObjectUtils.disposeObject(_para1);
         _para1 = null;
         ObjectUtils.disposeObject(_para2);
         _para2 = null;
         ObjectUtils.disposeObject(_para3);
         _para3 = null;
      }
   }
}

