package goldroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import manager.LanguageMgr;
   import managers.GoldRoadManager;
   import mvc.module.goldroad.GoldRoadGoodsInfo;
   import mvc.module.goldroad.GoldRoadModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class GoldRoadCell extends Component implements Disposeable
   {
      
      private var itemContiner:Component;
      
      private var iconBack:Bitmap;
      
      private var iconView:BaseItemView;
      
      private var questionMc:MovieClip;
      
      private var countBack:Image;
      
      private var count:FilterFrameText;
      
      private var _cellInfo:GoldRoadGoodsInfo;
      
      private var _ginfo:GoodsInfo;
      
      private var _scaleValue:Number;
      
      private var _rareScale:Number = 0.9;
      
      private var myMatrix:Matrix;
      
      public function GoldRoadCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         itemContiner = new Component();
         iconBack = ComponentFactory.Instance.creatBitmap("asset.GoldRoadCell.iconBack");
         iconView = ComponentFactory.Instance.creatCustomObject("GoldRoadCell.GoldRoadCellView");
         questionMc = ComponentFactory.Instance.creatCustomObject("GoldRoadCell.rareYellowMc");
         countBack = ComponentFactory.Instance.creatComponentByStylename("GoldRoadCell.countBack");
         count = ComponentFactory.Instance.creatComponentByStylename("GoldRoadCell.count");
         _ginfo = new GoodsInfo();
      }
      
      public function set data(param1:GoldRoadGoodsInfo) : void
      {
         _cellInfo = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         if(itemContiner && itemContiner.parent)
         {
            itemContiner.parent.removeChild(itemContiner);
         }
         if(questionMc && questionMc.parent)
         {
            questionMc.stop();
            questionMc.parent.removeChild(questionMc);
         }
         if(_cellInfo)
         {
            _scaleValue = model.getScale(model.xyArray[_cellInfo.cellValue][1]);
            this.isFollowMouse = false;
            this.tipStyle = "yishi.view.tips.OneLineTip";
            this.tipDirctions = "4,6,5,7,0,1,2,3";
            if(_cellInfo.tempId != -1)
            {
               myMatrix = new Matrix(0.52,0.15,0,0.52,2,17);
               iconView.transform.matrix = myMatrix;
               iconView.icon.icon = IconFactory.getGoodsIconByTID(_cellInfo.tempId);
               _ginfo.templateId = _cellInfo.tempId;
               iconView.data = _ginfo;
               addChild(itemContiner);
               itemContiner.addChild(iconBack);
               itemContiner.addChild(iconView);
               itemContiner.addChild(countBack);
               itemContiner.addChild(count);
               count.text = _cellInfo.count.toString();
               this.x = model.xyArray[_cellInfo.cellValue][0] - iconBack.width * _scaleValue / 2 + 10;
               this.y = model.xyArray[_cellInfo.cellValue][1] - iconBack.height * _scaleValue / 2 - 15;
               this.scaleX = this.scaleY = _scaleValue;
               this.tipData = "";
            }
            else
            {
               addChild(questionMc);
               questionMc.play();
               this.x = model.xyArray[_cellInfo.cellValue][0] - iconBack.width * _scaleValue / 2;
               this.y = model.xyArray[_cellInfo.cellValue][1] - iconBack.height * _scaleValue / 2 - 10;
               this.scaleX = this.scaleY = _scaleValue * _rareScale;
               this.tipData = LanguageMgr.GetTranslation("GoldRoadCell.randomEvent");
            }
         }
      }
      
      private function get model() : GoldRoadModel
      {
         return GoldRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(iconView)
         {
            ObjectUtils.disposeObject(iconView);
         }
         iconView = null;
         if(questionMc)
         {
            ObjectUtils.disposeViolentMc(questionMc);
         }
         questionMc = null;
         if(countBack)
         {
            ObjectUtils.disposeObject(countBack);
         }
         countBack = null;
         if(count)
         {
            ObjectUtils.disposeObject(count);
         }
         count = null;
         if(iconBack)
         {
            ObjectUtils.disposeObject(iconBack);
         }
         iconBack = null;
         if(itemContiner)
         {
            ObjectUtils.disposeAllChildren(itemContiner);
            ObjectUtils.disposeObject(itemContiner);
            itemContiner = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

