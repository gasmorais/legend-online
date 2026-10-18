package map.campaign.view.ui.molong
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.view.community.HeadIconCell;
   
   public class HeadComp extends Component
   {
      
      private var _headId:int;
      
      private var _roleName:String;
      
      private var _headCell:HeadIconCell;
      
      private var _text:FilterFrameText;
      
      public function HeadComp(param1:int, param2:String)
      {
         _headId = param1;
         _roleName = param2;
         super();
      }
      
      override protected function init() : void
      {
         _headCell = ComponentFactory.Instance.creatCustomObject("molong.headIconCell");
         _headCell.headId = _headId;
         this.addChild(_headCell);
         _text = ComponentFactory.Instance.creatComponentByStylename("molong.roleName");
         _text.text = _roleName;
         this.addChild(_text);
      }
      
      override public function dispose() : void
      {
         _headCell.dispose();
         _headCell = null;
         _text.dispose();
         _text = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

