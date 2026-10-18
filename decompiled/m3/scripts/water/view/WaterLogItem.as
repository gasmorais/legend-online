package water.view
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.text.StyleSheet;
   import manager.LanguageMgr;
   import water.data.WaterLogInfo;
   import yishi.utils.DateFormatter;
   
   public class WaterLogItem extends Sprite implements Disposeable, IListCell
   {
      
      private var _eventTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _data:WaterLogInfo;
      
      private var _typeImg:ScaleFrameImage;
      
      private var _typeTxt:FilterFrameText;
      
      private var _menu:ChatItemMenu;
      
      public function WaterLogItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.water.LogtFrameLine");
         addChild(_bg);
         _typeImg = ComponentFactory.Instance.creatComponentByStylename("core.EventLogTypeBg");
         _typeTxt = ComponentFactory.Instance.creatComponentByStylename("water.LogTypeText");
         _typeImg.y = 0;
         _typeImg.setFrame(1);
         _typeTxt.setFrame(1);
         addChild(_typeImg);
         addChild(_typeTxt);
         _eventTxt = ComponentFactory.Instance.creatComponentByStylename("water.LogTextStyle");
         addChild(_eventTxt);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("water.LogTimeText");
         addChild(_timeTxt);
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("a:hover",{"textDecoration":"underline"});
         _eventTxt.styleSheet = _loc1_;
         _eventTxt.mouseEnabled = true;
      }
      
      private function initEvent() : void
      {
         _eventTxt.addEventListener("link",__link);
      }
      
      private function removeEvent() : void
      {
         _eventTxt.removeEventListener("link",__link);
      }
      
      private function __link(param1:TextEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         _menu = new ChatItemMenu(_data.nickName,_data.waterUserId,false);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY + 7;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as WaterLogInfo;
         if(_data)
         {
            _typeImg.visible = _typeTxt.visible = true;
            switch(int(_data.type) - 1)
            {
               case 0:
                  _typeImg.setFrame(1);
                  _typeTxt.setFrame(1);
                  _typeTxt.text = LanguageMgr.GetTranslation("water.view.WaterLogItem.treelog");
                  break;
               case 1:
                  _typeImg.setFrame(2);
                  _typeTxt.setFrame(2);
                  _typeTxt.text = LanguageMgr.GetTranslation("water.view.WaterLogItem.farmlog");
            }
            _eventTxt.htmlText = "<font color=\'#fc7d00\'><a href=\'event:clickLink\'>[" + _data.nickName + "]</a></font>" + _data.actionDes;
            _timeTxt.text = DateFormatter.timeFormat2(_data.time);
         }
         else
         {
            _typeImg.visible = _typeTxt.visible = false;
            _eventTxt.text = "";
            _timeTxt.text = "";
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

