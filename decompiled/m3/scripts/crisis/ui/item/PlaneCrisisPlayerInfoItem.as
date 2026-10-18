package crisis.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.filter.UIFilter;
   import yishi.view.community.HeadIconCell;
   
   public class PlaneCrisisPlayerInfoItem extends Sprite
   {
      
      private var _iconBack:Bitmap;
      
      private var _colorBit:Bitmap;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _elargmentTxt:FilterFrameText;
      
      private var _actionTxt:FilterFrameText;
      
      private var _data:PlaneCrisisPlayerInfo;
      
      private var _iconHead:HeadIconCell;
      
      private var _currColor:int = -1;
      
      private var _currHeadId:int = -1;
      
      private var _iconMask:Shape;
      
      private var _gray:Array;
      
      public function PlaneCrisisPlayerInfoItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.planecrisis.headIconBack");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.gradeTxt");
         _elargmentTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.elargmentTxt");
         _actionTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.actionTxt");
         _iconHead = ComponentFactory.Instance.creatCustomObject("ui.planeCrisis.teamIconCell");
         _colorBit = new Bitmap();
         addChild(_iconBack);
         addChild(_iconHead);
         addChild(_elargmentTxt);
         addChild(_actionTxt);
         addChild(_gradeTxt);
         addChild(_colorBit);
         _colorBit.x = 12;
         _colorBit.y = 30;
         _iconMask = new Shape();
         _iconMask.graphics.beginFill(16711680);
         _iconMask.graphics.drawCircle(0,0,15);
         _iconMask.graphics.endFill();
         _iconMask.x = 23;
         _iconMask.y = 22;
         addChild(_iconMask);
         _iconHead.mask = _iconMask;
         _iconHead.type = "head";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_elargmentTxt);
         _elargmentTxt = null;
         ObjectUtils.disposeObject(_actionTxt);
         _actionTxt = null;
         ObjectUtils.disposeObject(_colorBit);
         _colorBit = null;
         ObjectUtils.disposeObject(_iconHead);
         _iconHead = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _gray = null;
      }
      
      public function get data() : PlaneCrisisPlayerInfo
      {
         return _data;
      }
      
      public function set data(param1:PlaneCrisisPlayerInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(_data != null)
         {
            if(_data.isOffline)
            {
               this.filters = _gray;
            }
            else
            {
               this.filters = null;
            }
            visible = true;
            _elargmentTxt.text = LanguageMgr.GetTranslation("planeCrisis.elargmentNum",_data.fragment);
            _actionTxt.text = LanguageMgr.GetTranslation("planeCrisis.movePowNum",_data.actionNum);
            _gradeTxt.text = "" + _data.armyData.baseHero.grades;
            if(_currColor != _data.color)
            {
               _colorBit.bitmapData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.RColor" + _data.color).bitmapData;
            }
            _currColor = _data.color;
            _loc2_ = int(_data.armyData.baseHero.headId);
            if(_currHeadId != _loc2_)
            {
               _iconHead.headId = _loc2_;
            }
            _currHeadId = _loc2_;
            _iconHead.tipData = _data.armyData.baseHero.nickName;
         }
         else
         {
            visible = false;
            _iconHead.tipData = null;
            _colorBit.bitmapData = null;
         }
      }
   }
}

