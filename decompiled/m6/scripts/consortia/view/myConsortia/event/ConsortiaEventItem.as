package consortia.view.myConsortia.event
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaEventInfo;
   import yishi.utils.DateFormatter;
   
   public class ConsortiaEventItem extends Sprite implements Disposeable, IListCell
   {
      
      private var _eventTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _typeTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _data:ConsortiaEventInfo;
      
      private var _typeImg:ScaleFrameImage;
      
      public function ConsortiaEventItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.eventFrameLine");
         _typeImg = ComponentFactory.Instance.creatComponentByStylename("core.EventLogTypeBg");
         _typeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.EventFrameMemberChangeTextStyle");
         _eventTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaEventnameTextStyle");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaEventTimeTextStyle");
         _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type");
         _typeImg.setFrame(1);
         _typeTxt.setFrame(1);
         addChild(_bg);
         addChild(_typeImg);
         addChild(_typeTxt);
         addChild(_eventTxt);
         addChild(_timeTxt);
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as ConsortiaEventInfo;
         if(_data)
         {
            _typeImg.visible = true;
            _eventTxt.htmlText = decode(_data.remark);
            _timeTxt.text = DateFormatter.timeFormat1(_data.createDate as Date);
         }
         else
         {
            _typeImg.visible = false;
            _typeTxt.text = "";
            _eventTxt.text = "";
            _timeTxt.text = "";
         }
      }
      
      private function decode(param1:String) : String
      {
         var _loc2_:Array = param1.split("|");
         switch(int(_data.types) - 1)
         {
            case 0:
            case 1:
               _typeImg.setFrame(1);
               _typeTxt.setFrame(1);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type");
               return "<font color=\'#fc7d00\'>" + _loc2_[0] + "</font> " + _loc2_[1] + " <font color=\'#fc7d00\'>" + _loc2_[2] + "</font> " + _loc2_[3];
            case 2:
               _typeImg.setFrame(1);
               _typeTxt.setFrame(1);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type");
               return "<font color=\'#fc7d00\'>" + _loc2_[0] + "</font> " + _loc2_[1];
            case 3:
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command01");
               return "<font color=\'#f1c143\'>" + _loc2_[0] + "</font> " + _loc2_[1];
            case 4:
            case 5:
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command01");
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               return _loc2_[0] + "<font color=\'#f1c143\'> " + _loc2_[1] + "</font> " + _loc2_[2];
            case 6:
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command02");
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               return _loc2_[0] + "<font color=\'#f1c143\'> " + _loc2_[1] + "</font> " + _loc2_[2];
            case 7:
               _typeImg.setFrame(1);
               _typeTxt.setFrame(1);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type02");
               return "<font color=\'#fc7d00\'>" + _loc2_[0] + "</font> ";
            case 8:
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type03");
               if(_loc2_.length == 3)
               {
                  return _loc2_[0] + " <font color=\'#fc7d00\'>" + _loc2_[1] + "</font> " + _loc2_[2];
               }
               return _loc2_[0];
               break;
            case 9:
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type04");
               return "<font color=\'#fc7d00\'>" + _loc2_[0] + "</font> " + _loc2_[1];
            case 10:
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command01");
               return _loc2_[0];
            case 11:
               _typeImg.setFrame(2);
               _typeTxt.setFrame(2);
               _typeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventItem.type12");
               return "<font color=\'#fc7d00\'>" + _loc2_[0] + "</font> " + _loc2_[1] + " <font color=\'#fc7d00\'>" + _loc2_[2] + "</font> " + _loc2_[3] + " <font color=\'#fc7d00\'>" + _loc2_[4] + "</font> ";
            default:
               return _loc2_[0];
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
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

