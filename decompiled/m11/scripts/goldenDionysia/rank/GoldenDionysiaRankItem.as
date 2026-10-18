package goldenDionysia.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import mvc.module.exchargerank.ExchargeRankData;
   
   public class GoldenDionysiaRankItem extends Component implements IListCell
   {
      
      private var _curData:ExchargeRankData;
      
      private var _vipBmp:Bitmap;
      
      private var _separateLine:ScaleLeftRightImage;
      
      private var _rankText:FilterFrameText;
      
      private var _userNameText:FilterFrameText;
      
      private var _agencyServerText:FilterFrameText;
      
      private var _rechargeNumberText:FilterFrameText;
      
      public function GoldenDionysiaRankItem()
      {
         super();
         _vipBmp = ComponentFactory.Instance.creatBitmap("asset.exchargerank.vipIcon");
         _separateLine = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRankItem.dataItem.gap");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRankItem.rankText");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRankItem.userNameText");
         _agencyServerText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRankItem.agencyServerText");
         _rechargeNumberText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRankItem.exchargeNumberText");
         _vipBmp.x = _userNameText.x - _vipBmp.width;
         _vipBmp.y = _userNameText.y;
         _vipBmp.visible = false;
         addChild(_vipBmp);
         addChild(_separateLine);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_agencyServerText);
         addChild(_rechargeNumberText);
      }
      
      private function updateUI(param1:uint, param2:String, param3:String, param4:String, param5:int, param6:Boolean) : void
      {
         _rankText.text = param1.toString();
         _userNameText.text = param2;
         _agencyServerText.text = param3;
         _rechargeNumberText.text = param4;
         if(param5 == 1)
         {
            _userNameText.visible = false;
         }
         else
         {
            _rechargeNumberText.visible = false;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _curData;
      }
      
      public function setCellValue(param1:*) : void
      {
         _curData = param1;
         var _loc2_:Boolean = true;
         updateUI(_curData.rank,_curData.nickName,_curData.agencyServer,_curData.amount,_curData.isVip,_loc2_);
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vipBmp);
         _vipBmp = null;
         ObjectUtils.disposeObject(_separateLine);
         _separateLine = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userNameText);
         _userNameText = null;
         ObjectUtils.disposeObject(_agencyServerText);
         _agencyServerText = null;
         ObjectUtils.disposeObject(_rechargeNumberText);
         _rechargeNumberText = null;
         _curData = null;
         super.dispose();
      }
   }
}

