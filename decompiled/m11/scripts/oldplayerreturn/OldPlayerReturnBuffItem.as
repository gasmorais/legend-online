package oldplayerreturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.AllyData;
   import flash.display.Bitmap;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.templates.OldPlayerReturnPrivilegeTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnBuffItem extends Component
   {
      
      private var _point:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _data:OldPlayerReturnPrivilegeTempInfo;
      
      public function OldPlayerReturnBuffItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _point = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnContractFrame.point");
         _txt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnBuffItem.txt");
         addChild(_point);
         addChild(_txt);
      }
      
      public function set data(param1:OldPlayerReturnPrivilegeTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(!allydata)
         {
            return;
         }
         _txt.text = _data.PrivilegeDes;
         _txt.height = 20 * _txt.numLines;
         if(_data.ContractLevel > allydata.contractLevel)
         {
            _txt.setFrame(1);
         }
         else
         {
            _txt.setFrame(2);
         }
      }
      
      private function get allydata() : AllyData
      {
         return model.selectedAllydata;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_point);
         _point = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

