package map.internals.view.hero
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import stage3drender.avatar.PetRender;
   
   public class PetNameView extends BaseNameView
   {
      
      private var _petQuaity:MovieClip;
      
      public function PetNameView()
      {
         super();
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(!_npcName)
         {
            _npcName = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PetNameText");
            addChild(_npcName);
         }
         _npcName.text = param1;
         _npcName.setFrame(param5);
         _npcName.x = -_npcName.width / 2;
         _npcName.y = -80;
         if(param5 == 5)
         {
            if(!_petQuaity)
            {
               _petQuaity = ComponentFactory.Instance.creat("asset.map.PetQuaityAsset");
            }
            if(!_petQuaity.parent)
            {
               addChild(_petQuaity);
               _petQuaity.x = -33;
               _petQuaity.y = _npcName.y;
            }
         }
         else
         {
            ObjectUtils.disposeObject(_petQuaity);
            _petQuaity = null;
         }
      }
      
      public function refreshView(param1:String, param2:int) : void
      {
         showName(param1,0,0,0,param2);
      }
      
      override public function layout() : void
      {
         var _loc1_:PetRender = heroView as PetRender;
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.followType == 1)
         {
            _npcName.y = getPosYBySizeType(_loc1_.sizeType,_loc1_.flight);
            if(_petQuaity)
            {
               _petQuaity.y = _npcName.y;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_petQuaity);
         _petQuaity = null;
         super.dispose();
      }
   }
}

