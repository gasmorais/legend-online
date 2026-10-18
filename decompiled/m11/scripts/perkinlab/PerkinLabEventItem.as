package perkinlab
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
   import mvc.module.perkinlab.PerkinLabLogInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class PerkinLabEventItem extends Sprite implements Disposeable, IListCell
   {
      
      private var _eventTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _typeTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _data:PerkinLabLogInfo;
      
      private var _typeImg:ScaleFrameImage;
      
      public function PerkinLabEventItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.perkinLab.eventFrameLine");
         _typeImg = ComponentFactory.Instance.creatComponentByStylename("core.EventLogTypeBg");
         _typeTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventItem.typeTextStyle");
         _eventTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventItem.nameTextStyle");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventItem.timeTextStyle");
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
         _data = param1 as PerkinLabLogInfo;
         if(_data)
         {
            _typeImg.visible = true;
            _typeImg.setFrame(_data.type);
            _typeTxt.setFrame(_data.type);
            _typeTxt.text = LanguageMgr.GetTranslation("PerkinLabEventItem.typeText.text" + _data.type);
            _eventTxt.htmlText = getEventText(_data);
            _timeTxt.text = DateFormatter.timeFormat1(_data.logTime as Date);
         }
         else
         {
            _typeImg.visible = false;
            _typeTxt.text = "";
            _eventTxt.text = "";
            _timeTxt.text = "";
         }
      }
      
      private function getEventText(param1:PerkinLabLogInfo) : String
      {
         var _loc11_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc10_:GoodsTemplateInfo = null;
         var _loc2_:String = "";
         var _loc9_:String = LanguageMgr.GetTranslation("PerkinLabEventItem.event.sizeText");
         var _loc4_:Array = param1.robReward.split("|");
         var _loc7_:int = int(_loc4_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc5_ = _loc4_[_loc11_];
            _loc6_ = _loc5_.split(",");
            _loc10_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_[0]);
            if(_loc10_)
            {
               _loc2_ += _loc10_.TemplateName + " x" + _loc6_[1] + ",";
            }
            _loc11_++;
         }
         _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf(","));
         var _loc3_:int = param1.isWin ? 1 : 0;
         return LanguageMgr.GetTranslation("PerkinLabEventItem.eventText.text" + param1.type + _loc3_,param1.rivalName,_loc9_,_loc2_);
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_typeImg)
         {
            ObjectUtils.disposeObject(_typeImg);
         }
         _typeImg = null;
         if(_typeTxt)
         {
            ObjectUtils.disposeObject(_typeTxt);
         }
         _typeTxt = null;
         if(_eventTxt)
         {
            ObjectUtils.disposeObject(_eventTxt);
         }
         _eventTxt = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

