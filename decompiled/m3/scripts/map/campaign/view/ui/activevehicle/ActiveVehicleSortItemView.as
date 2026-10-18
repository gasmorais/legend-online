package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.data.CampaignArmy;
   
   public class ActiveVehicleSortItemView extends Component
   {
      
      private var _data:CampaignArmy;
      
      private var _flag:ScaleFrameImage;
      
      private var _index:int;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function ActiveVehicleSortItemView(param1:int)
      {
         super();
         _index = param1;
         this.height = 25;
         this.mouseChildren = this.mouseEnabled = false;
         initView();
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         _data = param1;
         if(_data && _data.baseHero.nickName)
         {
            _numTxt.text = String(_index) + ".";
            _nameTxt.text = _data.baseHero.nickName;
            _scoreTxt.text = String(_data.activeScore);
            _flag.visible = true;
            _flag.setFrame(_data.activeTeamId);
            if(_index >= 4)
            {
               _numTxt.setFrame(4);
               _nameTxt.setFrame(4);
               _scoreTxt.setFrame(4);
            }
            else
            {
               _numTxt.setFrame(_index);
               _nameTxt.setFrame(_index);
               _scoreTxt.setFrame(_index);
            }
         }
         else
         {
            _numTxt.text = "";
            _nameTxt.text = "";
            _scoreTxt.text = "";
            _flag.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
      
      private function initView() : void
      {
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.numTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.nameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.scoreTxt");
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.width = _flag.height = 20;
         _flag.x = 7;
         _flag.y = 0;
         addChild(_numTxt);
         addChild(_flag);
         addChild(_nameTxt);
         addChild(_scoreTxt);
      }
      
      private function uintView() : void
      {
         if(_numTxt)
         {
            ObjectUtils.disposeObject(_numTxt);
         }
         _numTxt = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_scoreTxt)
         {
            ObjectUtils.disposeObject(_scoreTxt);
         }
         _scoreTxt = null;
         if(_flag)
         {
            ObjectUtils.disposeObject(_flag);
         }
         _flag = null;
      }
   }
}

